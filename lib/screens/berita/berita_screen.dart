// ignore_for_file: prefer_const_constructors, unused_field, camel_case_types, sized_box_for_whitespace

import 'package:flutter/material.dart';
// Keep imports minimal for this screen
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
        final imageUrl =
            item['attachments'] != null && item['attachments'].isNotEmpty
                ? item['attachments'][0]['url']
                : null;

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
    // Return only the page body; the AppBar is provided by the main shell
    // (HomePage) to keep a consistent top bar across tabs.
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
                      final news = displayedNews[index];
                      final imageUrl = news['imageUrl'];
                      final title = news['title'] ?? 'News';
                      final author = news['author'] ?? 'Admin';
                      final url = news['newsUrl'];

                      return InkWell(
                        onTap: () async {
                          final messenger = ScaffoldMessenger.of(context);
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
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Author & Tanggal di paling atas
                              Row(
                                children: [
                                  const Icon(Icons.person,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      author,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.access_time,
                                      size: 12, color: Colors.grey[500]),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatDate(news['pubDate'] ?? ''),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Gambar + Judul
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Gambar
                                  imageUrl != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            imageUrl,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            headers: const {
                                              'User-Agent':
                                                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                                            },
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Container(
                                                width: 100,
                                                height: 100,
                                                color: Colors.grey[100],
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder: (_, __, ___) {
                                              // URL Instagram expired, gunakan placeholder
                                              return Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Colors.blue[100]!,
                                                      Colors.blue[50]!,
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.article,
                                                        size: 36,
                                                        color:
                                                            Colors.blue[300]),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'Berita',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.blue[400],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.blue[100]!,
                                                Colors.blue[50]!,
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.article,
                                                  size: 36,
                                                  color: Colors.blue[300]),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Berita',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.blue[400],
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  const SizedBox(width: 12),
                                  // Judul + Icon
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              height: 1.3,
                                            ),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.open_in_new,
                                            size: 18, color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Pagination Controls
              if (allNews.isNotEmpty && _totalPages > 1)
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Previous button
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        onPressed: _currentPage > 1
                            ? () => _goToPage(_currentPage - 1)
                            : null,
                        icon: const Icon(Icons.chevron_left, size: 20),
                        color: _currentPage > 1 ? Colors.blue : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      // Page numbers
                      ..._buildPageNumbers(),
                      const SizedBox(width: 4),
                      // Next button
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        onPressed: _currentPage < _totalPages
                            ? () => _goToPage(_currentPage + 1)
                            : null,
                        icon: const Icon(Icons.chevron_right, size: 20),
                        color: _currentPage < _totalPages
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
            ],
          );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pages = [];
    int start = (_currentPage - 2).clamp(1, _totalPages);
    int end = (_currentPage + 2).clamp(1, _totalPages);

    // Adjust range if near start or end
    if (_currentPage <= 3) {
      start = 1;
      end = 5.clamp(1, _totalPages);
    } else if (_currentPage >= _totalPages - 2) {
      start = (_totalPages - 4).clamp(1, _totalPages);
      end = _totalPages;
    }

    for (int i = start; i <= end; i++) {
      pages.add(
        GestureDetector(
          onTap: () => _goToPage(i),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            constraints: const BoxConstraints(
              minWidth: 28,
              minHeight: 28,
            ),
            decoration: BoxDecoration(
              color: i == _currentPage ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: i == _currentPage ? Colors.blue : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                '$i',
                style: TextStyle(
                  fontSize: 13,
                  color: i == _currentPage ? Colors.white : Colors.black87,
                  fontWeight:
                      i == _currentPage ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return pages;
  }
}
