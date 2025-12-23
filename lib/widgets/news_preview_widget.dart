import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

/// Widget untuk menampilkan preview 3 berita terbaru dari RSS feeds
class NewsPreview extends StatefulWidget {
  const NewsPreview({super.key});

  @override
  State<NewsPreview> createState() => _NewsPreviewState();
}

class _NewsPreviewState extends State<NewsPreview> {
  List<Map<String, dynamic>> news = [];
  bool loading = true;

  final List<String> _rss = [
    'https://rss.app/feeds/v1.1/rHyalNohjMNACgTx.json',
    'https://rss.app/feeds/v1.1/YEWvQYsh1VcyU0a6.json',
    'https://rss.app/feeds/v1.1/oBYCZ1GV2crnFf21.json',
  ];

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inDays == 0) {
        if (diff.inHours == 0) {
          return '${diff.inMinutes} menit lalu';
        }
        return '${diff.inHours} jam lalu';
      } else if (diff.inDays == 1) {
        return 'Kemarin';
      } else if (diff.inDays < 7) {
        return '${diff.inDays} hari lalu';
      } else {
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'Mei',
          'Jun',
          'Jul',
          'Ags',
          'Sep',
          'Okt',
          'Nov',
          'Des'
        ];
        return '${date.day} ${months[date.month - 1]} ${date.year}';
      }
    } catch (e) {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    List<Map<String, dynamic>> fetched = [];
    for (var url in _rss) {
      try {
        final res = await http.get(Uri.parse(url));
        if (res.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(res.body);
          final items = data['items'] as List<dynamic>?;
          if (items != null) {
            for (var item in items) {
              fetched.add({
                'title': item['title'] ?? '',
                'url': item['url'],
                'image': (item['attachments'] != null &&
                        item['attachments'].isNotEmpty)
                    ? item['attachments'][0]['url']
                    : null,
                'pubDate': item['date_published'] ?? '',
                'summary': item['content_text'] ?? '',
                'author': item['author']?['name'] ?? data['title'] ?? 'Admin',
              });
            }
          }
        }
      } catch (_) {}
    }
    fetched.sort((a, b) {
      try {
        return DateTime.parse(b['pubDate'])
            .compareTo(DateTime.parse(a['pubDate']));
      } catch (_) {
        return 0;
      }
    });
    setState(() {
      news = fetched.take(3).toList();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
          child: SizedBox(
              height: 48, width: 48, child: CircularProgressIndicator()));
    }

    if (news.isEmpty) return const SizedBox();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < news.length; i++) ...[
          _buildNewsTile(context, news[i]),
          if (i < news.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Divider(height: 1, thickness: 1),
            ),
        ],
      ],
    );
  }

  Widget _buildNewsTile(BuildContext context, Map<String, dynamic> item) {
    final imageUrl = item['image'] as String?;
    final title = item['title'] ?? '';
    final author = item['author'] ?? 'Admin';
    final pubDate = item['pubDate'] ?? '';
    final url = item['url'];

    return InkWell(
      onTap: () async {
        final messenger = ScaffoldMessenger.of(context);
        if (url != null && Uri.tryParse(url)?.isAbsolute == true) {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            messenger.showSnackBar(
                const SnackBar(content: Text('Could not launch the URL.')));
          }
        } else {
          messenger.showSnackBar(const SnackBar(content: Text('Invalid URL.')));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author & Tanggal
            Row(
              children: [
                const Icon(Icons.account_circle, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    author,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.access_time, size: 13, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  _formatDate(pubDate),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Gambar + Judul
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gambar
                imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                          headers: const {
                            'User-Agent':
                                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                          },
                          errorBuilder: (_, __, ___) => Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.blue[100]!,
                                  Colors.blue[50]!,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.article,
                                    size: 48, color: Colors.blue[300]),
                                const SizedBox(height: 6),
                                Text(
                                  'Berita',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue[100]!,
                              Colors.blue[50]!,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.article,
                                size: 48, color: Colors.blue[300]),
                            const SizedBox(height: 6),
                            Text(
                              'Berita',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue[400],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(width: 14),
                // Judul + Icon
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                height: 1.4,
                              ),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Icon(Icons.open_in_new,
                                size: 18, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
