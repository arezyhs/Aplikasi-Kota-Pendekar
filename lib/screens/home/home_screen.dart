import 'package:flutter/material.dart';
import 'package:pendekar/homepage/views/components/home_banner.dart';
// Embedded Home-only widgets: Layanan Utama and Informasi Publik
import 'package:pendekar/homepage/views/components/dialog_warning.dart';
import 'package:pendekar/homepage/menu/layananinformasi.dart';
import 'package:pendekar/homepage/menu/layanankesehatan.dart';
import 'package:pendekar/homepage/menu/layananpublik.dart';
import 'package:pendekar/homepage/menu/layananpengaduan.dart';
import 'package:pendekar/homepage/menu/layanan_asn.dart';
// spotlight pages
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/mbangunswarga.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/manekin.dart';
import 'package:pendekar/homepage/views/components/radio93fm.dart';
import 'package:pendekar/homepage/views/components/home_caraousel.dart';
import 'package:pendekar/homepage/views/components/section_header.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:pendekar/homepage/views/components/switch_tab_notification.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/ppid.dart';

// Small news preview widget (fetches top 3 news from configured RSS json feeds)
class NewsPreview extends StatefulWidget {
  const NewsPreview({super.key});

  @override
  State<NewsPreview> createState() => _NewsPreviewState();
}

class _NewsPreviewState extends State<NewsPreview> {
  List<Map<String, dynamic>> news = [];
  bool loading = true;
  // _active no longer used (was for carousel indicators)

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
      news = fetched.take(3).toList(); // show only 3 news items
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

    // show exactly 3 latest news items with larger images
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
            // Gambar + Judul (larger image)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar - Larger size
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // Use clamping physics to avoid large bounce/overscroll on Home.
      // This makes scroll behaviour consistent with non-bouncy pages.
      physics: const ClampingScrollPhysics(),
      slivers: [
        // Banner (clean, no overlay)
        const SliverToBoxAdapter(child: HomeBanner()),

        const SliverToBoxAdapter(child: SizedBox(height: 12)),

        // Emergency Bar: Awak Sigap
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () async {
                final whatsappUrl = Uri.parse('https://wa.me/08113577800');
                if (await canLaunchUrl(whatsappUrl)) {
                  await launchUrl(whatsappUrl,
                      mode: LaunchMode.externalApplication);
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF6B35),
                      Color(0xFFFF8C42),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6B35).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/images/imgicon/awaksigap.png',
                        width: 32,
                        height: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'AWAK SIGAP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Anda WA, Kami Siap Segera Tanggap!',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.95),
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 14)),

        // Featured Programs & Layanan Utama Grid
        const SliverToBoxAdapter(
          child: Column(
            children: [
              SectionHeader(title: 'Layanan Utama'),
              SizedBox(height: 8),
              _LayananUtama(),
              SizedBox(height: 14),
            ],
          ),
        ),

        // Berita Terkini
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionHeader(
                title: 'Berita Terkini',
                onSeeAll: () {
                  // Request parent shell to switch to Berita tab (index 2)
                  const SwitchTabNotification(2).dispatch(context);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        // News preview (3 items)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: NewsPreview(),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 14)),

        // PPID banner + Radio (Informasi Publik)
        const SliverToBoxAdapter(
          child: Column(
            children: [
              SectionHeader(title: 'Informasi Publik'),
              SizedBox(height: 12),
              // carousel containing PPID banner(s) and radio slide
              _InformasiPublik(),
              SizedBox(height: 12),
            ],
          ),
        ),

        // Home Carousel
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: HomeCaraousel(),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}

// ----- Embedded Layanan Utama (home-only) -----
class _LayananUtama extends StatefulWidget {
  const _LayananUtama({Key? key}) : super(key: key);

  @override
  State<_LayananUtama> createState() => _LayananUtamaState();
}

class _LayananUtamaState extends State<_LayananUtama> {
  @override
  Widget build(BuildContext context) {
    // featured services (Mbangun Swarga & Manekin) — keep these separate
    final featured = [
      {
        "icon": "assets/images/imgicon/mbangun.png",
        "text": "MBANGUN SWARGA",
        "page": const WebMbangunswarga()
      },
      {
        "icon": "assets/images/imgicon/manekin.png",
        "text": "MANEKIN",
        "page": const WebManekin()
      },
    ];

    // categories grid (exclude featured) - top 6 most important services
    final combined = [
      {
        "icon": "assets/images/imgicon/puskesmas.png",
        "text": "Layanan Kesehatan",
        "page": const LayananKesehatan()
      },
      {
        "icon": "assets/images/imgicon/pasaremadiun.png",
        "text": "Layanan Publik",
        "page": const LayananPublik()
      },
      {
        "icon": "assets/images/imgicon/wbs.png",
        "text": "Layanan Pengaduan",
        "page": const LayananPengaduan()
      },
      {
        "icon": "assets/images/imgicon/opendata.png",
        "text": "Layanan Informasi",
        "page": const LayananInformasi()
      },
      {
        "icon": "assets/images/imgicon/cctv.png",
        "text": "CCTV",
        "appId": "id.olean.cctv_madiun",
        "uriScheme": "cctv://",
      },
      {
        "icon": "assets/images/imgicon/ekinerja.png",
        "text": "Layanan ASN",
        "page": const LayananAsn()
      },
    ];

    // Show only top 6 services
    final categories = combined.take(6).toList();

    return Column(
      children: [
        // categories grid 3x2
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
            childAspectRatio: 1.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              categories.length,
              (index) {
                final item = categories[index];
                final screenWidth = MediaQuery.of(context).size.width;
                return InkWell(
                  onTap: () async {
                    final page = item['page'];
                    final appId = item['appId'] as String?;

                    if (appId != null) {
                      // Handle external app (CCTV)
                      final playStoreUrl =
                          'https://play.google.com/store/apps/details?id=$appId';
                      final uri = Uri.parse(playStoreUrl);
                      final messenger = ScaffoldMessenger.of(context);

                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      } else {
                        messenger.showSnackBar(
                          const SnackBar(
                              content: Text('Tidak dapat membuka Play Store')),
                        );
                      }
                    } else if (page is DialogWarning) {
                      DialogWarning.show(context);
                    } else if (page is Widget) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => page));
                    }
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: screenWidth * 0.20,
                        height: screenWidth * 0.16,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).shadowColor.withAlpha(15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            item['icon'] as String,
                            width: screenWidth * 0.14,
                            height: screenWidth * 0.14,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Flexible(
                        child: MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            textScaler: TextScaler.noScaling,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              width: screenWidth * 0.28,
                              child: Text(
                                item['text'] as String,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 6),

        // "Lihat Semua Layanan" button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: OutlinedButton(
            onPressed: () {
              // Navigate to Layanan tab (index 1)
              const SwitchTabNotification(1).dispatch(context);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.grid_view,
                    color: Theme.of(context).colorScheme.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Lihat Semua Layanan',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Featured Programs: Mbangun Swarga & Manekin
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: featured.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final item = featured[index];
                final screenWidth = MediaQuery.of(context).size.width;
                final cardWidth = (screenWidth - 48) / 1.3; // Larger cards

                // Gradient colors for each program
                final gradients = [
                  [
                    const Color(0xFF4A90E2),
                    const Color(0xFF357ABD)
                  ], // Blue for Mbangun Swarga
                  [
                    const Color(0xFF50C878),
                    const Color(0xFF3D9E5D)
                  ], // Green for Manekin
                ];

                return GestureDetector(
                  onTap: () {
                    final page = item['page'];
                    if (page is DialogWarning) {
                      DialogWarning.show(context);
                    } else if (page is Widget) {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => page));
                    }
                  },
                  child: Container(
                    width: cardWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradients[index],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: gradients[index][0].withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Decorative circle background
                        Positioned(
                          right: -30,
                          top: -30,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -20,
                          bottom: -20,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.05),
                            ),
                          ),
                        ),
                        // Content
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Icon
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .shadowColor
                                          .withValues(alpha: 0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Image.asset(
                                  item['icon'] as String,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // Text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      textScaler: TextScaler.noScaling,
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item['text'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      textScaler: TextScaler.noScaling,
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        index == 0
                                            ? 'Aspirasi & Pengaduan Warga'
                                            : 'Manajemen Kinerja ASN',
                                        style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.9),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      textScaler: TextScaler.noScaling,
                                    ),
                                    child: const Row(
                                      children: [
                                        Text(
                                          'Akses Sekarang',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}

// ----- Embedded Informasi Publik banner -----
class _InformasiPublik extends StatefulWidget {
  const _InformasiPublik({Key? key}) : super(key: key);

  @override
  State<_InformasiPublik> createState() => _InformasiPublikState();
}

class _InformasiPublikState extends State<_InformasiPublik> {
  final PageController _controller = PageController(viewportFraction: 0.94);
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // size not needed for this widget
    // slides: banners + radio
    final banners = ['assets/images/ppidbanner.png'];
    final List<Widget> slides = [
      for (final img in banners)
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WebPpid()),
          ),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: Center(
                child: Image.asset(
                  img,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ),
      // Radio slide: re-use HomePlayer so audio controls work inline
      Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          height: 160,
          width: double.infinity,
          child: HomePlayer(),
        ),
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemCount: slides.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: slides[index],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            slides.length,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: _page == i ? 10 : 8,
              height: _page == i ? 10 : 8,
              decoration: BoxDecoration(
                color: _page == i ? Colors.blueAccent : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
