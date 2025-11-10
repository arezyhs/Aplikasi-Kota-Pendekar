import 'package:flutter/material.dart';
import 'package:pendekar/homepage/views/components/home_banner.dart';
// Embedded Home-only widgets: Layanan Utama and Informasi Publik
import 'package:pendekar/homepage/views/components/circle_category.dart';
import 'package:pendekar/homepage/views/components/dialogWarning.dart';
import 'package:pendekar/homepage/menu/layananinformasi.dart';
import 'package:pendekar/homepage/menu/layanankesehatan.dart';
import 'package:pendekar/homepage/menu/lainnya.dart';
import 'package:pendekar/homepage/menu/layananpublik.dart';
import 'package:pendekar/homepage/menu/layananpengaduan.dart';
import 'package:pendekar/homepage/menu/layananAsn.dart';
// spotlight pages
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/mbangunswarga.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/manekin.dart';
import 'package:pendekar/homepage/views/components/radio93fm.dart';
import 'package:pendekar/homepage/views/components/home_description.dart';
import 'package:pendekar/homepage/views/components/home_caraousel.dart';
import 'package:pendekar/homepage/views/components/section_header.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
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

  final List<String> _rss = [
    'https://rss.app/feeds/v1.1/rHyalNohjMNACgTx.json',
    'https://rss.app/feeds/v1.1/YEWvQYsh1VcyU0a6.json',
    'https://rss.app/feeds/v1.1/oBYCZ1GV2crnFf21.json',
  ];

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
    if (loading)
      return const Center(
          child: SizedBox(
              height: 48, width: 48, child: CircularProgressIndicator()));
    if (news.isEmpty) return const SizedBox();

    return Column(
      children: news.map((item) {
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: item['image'] != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(item['image'],
                      width: 80,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                          width: 80, height: 64, color: Colors.grey[200])),
                )
              : Container(
                  width: 80,
                  height: 64,
                  color: Colors.grey[200],
                  child: const Icon(Icons.article, color: Colors.grey)),
          title: Text(item['title'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(item['summary'] ?? '',
              maxLines: 2, overflow: TextOverflow.ellipsis),
          trailing: IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () async {
              final url = item['url'];
              if (url != null && Uri.tryParse(url)?.isAbsolute == true) {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              }
            },
          ),
          onTap: () async {
            final url = item['url'];
            if (url != null && Uri.tryParse(url)?.isAbsolute == true) {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            }
          },
        );
      }).toList(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Banner with a compact WhatsApp CTA overlaid
          SliverToBoxAdapter(
            child: Stack(
              children: [
                const HomeBanner(),
                // Positioned CTA button moved to bottom-right so it doesn't cover banner content
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: GestureDetector(
                    onTap: () async {
                      final whatsappUrl =
                          Uri.parse('https://wa.me/08113577800');
                      if (await canLaunchUrl(whatsappUrl)) {
                        await launchUrl(whatsappUrl,
                            mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2)),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/imgicon/awaksigap.png',
                              width: 22, height: 22),
                          const SizedBox(width: 6),
                          const Text('AWAK SIGAP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(child: const SizedBox(height: 12)),

          // Menu utama
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SectionHeader(title: 'Layanan Utama'),
                const SizedBox(height: 8),
                _LayananUtama(),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // PPID banner + Radio
          SliverToBoxAdapter(
            child: Column(
              children: const [
                SectionHeader(title: 'Informasi Publik'),
                SizedBox(height: 12),
                // embedded PPID banner
                _InformasiPublik(),
                SizedBox(height: 12),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: HomePlayer(),
            ),
          ),

          // Berita
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                SectionHeader(title: 'Berita Terkini'),
                // HomeDescription kept for intro text
                HomeDescription(),
                SizedBox(height: 8),
              ],
            ),
          ),
          // Small news preview (top 3)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const NewsPreview(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: HomeCaraousel(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
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
        "page": WebMcm()
      },
      {
        "icon": "assets/images/imgicon/manekin.png",
        "text": "MANEKIN",
        "page": webmanekin()
      },
    ];

    // categories grid (exclude featured) - follow user's requested set
    final combined = [
      {
        "icon": "assets/images/imgicon/puskesmas.png",
        "text": "Layanan Kesehatan",
        "page": LayananKesehatan()
      },
      {
        "icon": "assets/images/imgicon/pasaremadiun.png",
        "text": "Layanan Publik",
        "page": LayananPublik()
      },
      {
        "icon": "assets/images/imgicon/wbs.png",
        "text": "Layanan Pengaduan",
        "page": LayananPengaduan()
      },
      {
        "icon": "assets/images/imgicon/opendata.png",
        "text": "Layanan Informasi",
        "page": LayananInformasi()
      },
      {
        "icon": "assets/images/imgicon/ekinerja.png",
        "text": "Layanan ASN",
        "page": LayananAsn()
      },
      {
        "icon": "assets/images/imgicon/cctv.png",
        "text": "CCTV",
        "appId": "id.olean.cctv_madiun",
        "uriScheme": "cctv://",
      },
      {
        "icon": "assets/images/imgicon/menu.png",
        "text": "Lainnya",
        "page": Lainnya()
      },
    ];

    // categories grid: show up to 8
    final categories = combined.take(8).toList();

    return Column(
      children: [
        // categories grid 2x4
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              categories.length,
              (index) {
                final item = categories[index];
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleCategory(iconPath: item['icon'] as String),
                      const SizedBox(height: 6),
                      Flexible(
                        child: Text(
                          item['text'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.028,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 12),

        // featured layanan (horizontal scroll)
        Padding(
          // align featured with section paddings
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            // give enough height for the card and its contents, avoid overflow on small screens
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: featured.length,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = featured[index];
                final screenWidth = MediaQuery.of(context).size.width;
                final cardWidth = (screenWidth * 0.45).clamp(140.0, 260.0);
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
                  child: SizedBox(
                    width: cardWidth,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // use a smaller circular icon here to keep the card compact
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2)),
                                ],
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Image.asset(
                                  item['icon'] as String,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['text'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
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
class _InformasiPublik extends StatelessWidget {
  const _InformasiPublik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final banners = [
      'assets/images/ppidbanner.png',
      // add more images later if needed
    ];

    return SizedBox(
      height: size.height * 0.14,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: banners.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final img = banners[index];
          return SizedBox(
            width: size.width - 64,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => webppid()));
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(img), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
