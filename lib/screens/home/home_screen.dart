import 'package:flutter/material.dart';
import 'package:pendekar/homepage/views/components/home_banner.dart';
// Embedded Home-only widgets: Layanan Utama and Informasi Publik
// circle_category not used after layout update
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
import 'package:pendekar/homepage/views/components/switch_tab_notification.dart';
// carousel_slider removed; news preview now a 3-item list
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
      news = fetched.take(5).toList(); // show up to 5 slides
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

    // show a simple list of up to 3 latest news items (styled like BeritaPage)
    final displayCount = news.length < 3 ? news.length : 3;
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < displayCount; i++) ...[
            _buildNewsTile(context, news[i]),
            if (i < displayCount - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }

  Widget _buildNewsTile(BuildContext context, Map<String, dynamic> item) {
    final imageUrl = item['image'] as String?;
    final title = item['title'] ?? '';
    final summary = item['summary'] ?? '';
    final url = item['url'];

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
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
              child: const Icon(Icons.article, size: 36, color: Colors.grey),
            ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(summary, maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
        icon: const Icon(Icons.open_in_new),
        onPressed: () async {
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
            messenger
                .showSnackBar(const SnackBar(content: Text('Invalid URL.')));
          }
        },
      ),
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
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        // Use clamping physics to avoid large bounce/overscroll on Home.
        // This makes scroll behaviour consistent with non-bouncy pages.
        physics: const ClampingScrollPhysics(),
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
              children: [
                const SectionHeader(title: 'Informasi Publik'),
                const SizedBox(height: 12),
                // carousel containing PPID banner(s) and radio slide
                const _InformasiPublik(),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // Berita
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
                // HomeDescription kept for intro text
                const HomeDescription(),
                const SizedBox(height: 8),
              ],
            ),
          ),
          // Small news preview (top 3)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: NewsPreview(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: HomeCaraousel(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
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
        "page": WebMbangunswarga()
      },
      {
        "icon": "assets/images/imgicon/manekin.png",
        "text": "MANEKIN",
        "page": WebManekin()
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
                final screenWidth = MediaQuery.of(context).size.width;
                return InkWell(
                  onTap: () {
                    final page = item['page'];
                    if (page is DialogWarning) {
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
                        width: screenWidth * 0.18,
                        height: screenWidth * 0.14,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            item['icon'] as String,
                            width: screenWidth * 0.12,
                            height: screenWidth * 0.12,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
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
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
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
                                boxShadow: const [
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
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
            MaterialPageRoute(builder: (context) => WebPpid()),
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
