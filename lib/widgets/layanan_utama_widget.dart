import 'package:flutter/material.dart';
import 'package:pendekar/screens/layanan/layanan_informasi_screen.dart';
import 'package:pendekar/screens/layanan/layanan_kesehatan_screen.dart';
import 'package:pendekar/screens/layanan/layanan_publik_screen.dart';
import 'package:pendekar/screens/layanan/layanan_pengaduan_screen.dart';
import 'package:pendekar/screens/layanan/layanan_asn_screen.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/mbangunswarga.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/cctv.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/manekin.dart';
import 'package:pendekar/widgets/dialog_warning.dart';
import 'package:pendekar/utils/notifications/switch_tab_notification.dart';
import 'package:pendekar/constants/constant.dart';

/// Widget untuk menampilkan grid Layanan Utama dan Featured Programs
class LayananUtamaWidget extends StatelessWidget {
  const LayananUtamaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Featured categories - top 6 dari Layanan Utama
    final categories = [
      {
        "icon": "assets/images/imgicon/puskesmas.png",
        "text": "Kesehatan",
        "page": const LayananKesehatanScreen()
      },
      {
        "icon": "assets/images/imgicon/pasaremadiun.png",
        "text": "Publik",
        "page": const LayananPublikScreen()
      },
      {
        "icon": "assets/images/imgicon/wbs.png",
        "text": "Pengaduan",
        "page": const LayananPengaduanScreen()
      },
      {
        "icon": "assets/images/imgicon/opendata.png",
        "text": "Informasi",
        "page": const LayananInformasiScreen()
      },
      {
        "icon": "assets/images/imgicon/ekinerja.png",
        "text": "ASN",
        "page": const LayananAsnScreen()
      },
      {
        "icon": "assets/images/imgicon/cctv.png",
        "text": "CCTV",
        "page": const WebCctv(),
      },
    ];

    // Featured programs: Mbangun Swarga & Manekin
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

    return Column(
      children: [
        // Categories grid 3x2
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
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
                    if (page is Widget) {
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
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                            width: screenWidth * 0.28,
                            child: Text(
                              item['text'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: AppTextSize.caption,
                                fontWeight: AppFontWeight.medium,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: OutlinedButton(
            onPressed: () {
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
                    fontWeight: AppFontWeight.medium,
                    fontSize: AppTextSize.subtitle,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Featured Programs: Mbangun Swarga & Manekin
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: SizedBox(
            height: 190,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: featured.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final item = featured[index];
                final screenWidth = MediaQuery.of(context).size.width;
                final cardWidth = (screenWidth - 48) / 1.3;

                final gradients = [
                  [const Color(0xFF4A90E2), const Color(0xFF357ABD)],
                  [const Color(0xFF50C878), const Color(0xFF3D9E5D)],
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
                        // Decorative circles
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
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Icon
                              Container(
                                width: 56,
                                height: 56,
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
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item['text'] as String,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: AppTextSize.heading,
                                        fontWeight: AppFontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      index == 0
                                          ? 'Aspirasi & Pengaduan Warga'
                                          : 'Manajemen Kinerja ASN',
                                      style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.9),
                                        fontSize: AppTextSize.body,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Akses Sekarang',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: AppTextSize.body,
                                            fontWeight: AppFontWeight.medium,
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
                                  ],
                                ),
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
