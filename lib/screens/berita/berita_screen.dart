// ignore_for_file: prefer_const_constructors, unused_field, camel_case_types, sized_box_for_whitespace

import 'package:flutter/material.dart';
// Keep imports minimal for this screen
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  List<Map<String, dynamic>> newsList = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    List<String> urls = [
      'https://rss.app/feeds/v1.1/rHyalNohjMNACgTx.json',
      'https://rss.app/feeds/v1.1/YEWvQYsh1VcyU0a6.json',
      'https://rss.app/feeds/v1.1/oBYCZ1GV2crnFf21.json',
    ];

    List<Map<String, dynamic>> fetchedNews = [];

    for (var url in urls) {
      try {
        var newsItems = await fetchNewsFromRss(url);
        if (newsItems != null) {
          fetchedNews.addAll(newsItems);
        }
      } catch (e) {
        debugPrint('Error fetching news from $url: $e');
      }
    }

    fetchedNews.sort((a, b) =>
        DateTime.parse(b['pubDate']).compareTo(DateTime.parse(a['pubDate'])));

    setState(() {
      newsList = fetchedNews.take(10).toList();
      _loading = false;
    });
  }

  Future<List<Map<String, dynamic>>?> fetchNewsFromRss(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> items = data['items'];

      return items.map((item) {
        return {
          'imageUrl':
              item['attachments'] != null && item['attachments'].isNotEmpty
                  ? item['attachments'][0]['url']
                  : null,
          'contentText': item['content_text'] ?? '',
          'title': item['title'] ?? 'News Post',
          'newsUrl': item['url'],
          'pubDate': item['date_published'] ?? '',
        };
      }).toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Return only the page body; the AppBar is provided by the main shell
    // (HomePage) to keep a consistent top bar across tabs.
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: fetchNews,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: news['imageUrl'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            news['imageUrl'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image),
                            ),
                          ),
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.article,
                              size: 36, color: Colors.grey),
                        ),
                  title: Text(
                    news['title'] ?? 'News',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    news['contentText'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.open_in_new),
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      final url = news['newsUrl'];
                      if (url != null &&
                          Uri.tryParse(url)?.isAbsolute == true) {
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                        } else {
                          messenger.showSnackBar(
                            const SnackBar(
                                content: Text('Could not launch the URL.')),
                          );
                        }
                      } else {
                        messenger.showSnackBar(
                          const SnackBar(content: Text('Invalid URL.')),
                        );
                      }
                    },
                  ),
                  onTap: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final url = news['newsUrl'];
                    if (url != null && Uri.tryParse(url)?.isAbsolute == true) {
                      final uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      } else {
                        messenger.showSnackBar(
                          const SnackBar(
                              content: Text('Could not launch the URL.')),
                        );
                      }
                    } else {
                      messenger.showSnackBar(
                        const SnackBar(content: Text('Invalid URL.')),
                      );
                    }
                  },
                );
              },
            ),
          );
  }
}
