import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pendekar/utils/services/app_config.dart';
import 'package:pendekar/utils/services/logger_service.dart';
import 'package:pendekar/widgets/news_item_widget.dart';
import 'package:pendekar/widgets/pagination_widget.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  List<Map<String, dynamic>> allNews = [];
  List<Map<String, dynamic>> displayedNews = [];
  bool _loading = true;
  int _currentPage = 1;
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadSavedPage();
    fetchNews();
  }

  Future<void> _loadSavedPage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPage = prefs.getInt('berita_current_page') ?? 1;
    setState(() {
      _currentPage = savedPage;
    });
  }

  Future<void> _savePage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('berita_current_page', page);
  }

  void _updateDisplayedNews() {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage).clamp(0, allNews.length);
    setState(() {
      displayedNews = allNews.sublist(startIndex, endIndex);
    });
  }

  int get _totalPages => (allNews.length / _itemsPerPage).ceil();

  void _goToPage(int page) {
    if (page >= 1 && page <= _totalPages) {
      setState(() {
        _currentPage = page;
      });
      _updateDisplayedNews();
      _savePage(page);
    }
  }

  Future<void> fetchNews() async {
    List<String> urls = AppConfig.rssFeedUrls;

    List<Map<String, dynamic>> fetchedNews = [];

    for (var url in urls) {
      try {
        var newsItems = await fetchNewsFromRss(url);
        if (newsItems != null) {
          fetchedNews.addAll(newsItems);
        }
      } catch (e) {
        Logger.error('Error fetching news from $url', error: e);
      }
    }

    fetchedNews.sort((a, b) =>
        DateTime.parse(b['pubDate']).compareTo(DateTime.parse(a['pubDate'])));

    setState(() {
      allNews = fetchedNews;
      // Maintain current page if valid, otherwise reset to 1
      final newTotalPages = (fetchedNews.length / _itemsPerPage).ceil();
      if (_currentPage > newTotalPages) {
        _currentPage = 1;
        _savePage(1);
      }
      _loading = false;
    });
    _updateDisplayedNews();
  }

  Future<List<Map<String, dynamic>>?> fetchNewsFromRss(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> items = data['items'];

      return items.map((item) {
        // Coba ambil dari attachments dulu, kalau tidak ada ambil dari field image
        var imageUrl =
            item['attachments'] != null && item['attachments'].isNotEmpty
                ? item['attachments'][0]['url']
                : item['image'];

        // Jika masih null, coba extract dari content_html
        if (imageUrl == null && item['content_html'] != null) {
          final htmlContent = item['content_html'] as String;
          final imgTagMatch =
              RegExp(r'<img[^>]+src="([^">]+)"').firstMatch(htmlContent);
          if (imgTagMatch != null) {
            imageUrl = imgTagMatch.group(1);
          }
        }

        return {
          'imageUrl': imageUrl,
          'title': item['title'] ?? 'News Post',
          'newsUrl': item['url'],
          'pubDate': item['date_published'] ?? '',
          'author': item['author']?['name'] ?? data['title'] ?? 'Admin',
        };
      }).toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: fetchNews,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemCount: displayedNews.length,
                    itemBuilder: (context, index) {
                      return NewsItemWidget(news: displayedNews[index]);
                    },
                  ),
                ),
              ),
              // Pagination Controls
              if (allNews.isNotEmpty)
                PaginationWidget(
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  onPageChanged: _goToPage,
                ),
            ],
          );
  }
}
