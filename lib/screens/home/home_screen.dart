import 'package:flutter/material.dart';
import 'package:pendekar/widgets/home_banner.dart';
import 'package:pendekar/widgets/radio_player.dart';
import 'package:pendekar/widgets/home_carousel.dart';
import 'package:pendekar/widgets/section_header.dart';
import 'package:pendekar/utils/notifications/switch_tab_notification.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/ppid.dart';
import 'package:pendekar/widgets/news_preview_widget.dart';
import 'package:pendekar/widgets/layanan_utama_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pendekar/constants/constant.dart';

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

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

        // Emergency Bar: Awak Sigap
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: GestureDetector(
              onTap: () async {
                final whatsappUrl = Uri.parse('https://wa.me/08113577800');
                if (await canLaunchUrl(whatsappUrl)) {
                  await launchUrl(whatsappUrl,
                      mode: LaunchMode.externalApplication);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl, vertical: AppSpacing.md),
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
                      padding: const EdgeInsets.all(AppSpacing.sm),
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
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'AWAK SIGAP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppTextSize.subtitle,
                              fontWeight: AppFontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            'Anda WA, Kami Siap Segera Tanggap!',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.95),
                              fontSize: AppTextSize.caption,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

        // Featured Programs & Layanan Utama Grid
        const SliverToBoxAdapter(
          child: Column(
            children: [
              SectionHeader(title: 'Layanan Utama'),
              SizedBox(height: AppSpacing.sm),
              LayananUtamaWidget(),
              SizedBox(height: AppSpacing.lg),
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
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
        // News preview (3 items)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: NewsPreview(),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

        // PPID banner + Radio (Informasi Publik) - displayed separately, not in carousel
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SectionHeader(title: 'Informasi Publik'),
              const SizedBox(height: AppSpacing.sm),
              // PPID banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WebPpid()),
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: Center(
                        child: Image.asset(
                          'assets/images/ppidbanner.png',
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // Radio - displayed separately for better visibility
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.hardEdge,
                  child: const SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: RadioPlayer(),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),

        // Home Carousel
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: HomeCarousel(),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
      ],
    );
  }
}
