import 'package:flutter/material.dart';
import 'package:pendekar/homepage/views/components/home_banner.dart';
import 'package:pendekar/homepage/views/components/home_wa.dart';
import 'package:pendekar/homepage/views/components/categories.dart';
import 'package:pendekar/homepage/views/components/ppidbanner.dart';
import 'package:pendekar/homepage/views/components/radio93fm.dart';
import 'package:pendekar/homepage/views/components/home_description.dart';
import 'package:pendekar/homepage/views/components/home_caraousel.dart';
import 'package:pendekar/homepage/views/components/section_header.dart';

class BodyV2 extends StatelessWidget {
  const BodyV2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // The AppBar is provided by the main shell (`HomePage`) so this
          // sliver is removed to avoid duplicate headers and keep a
          // consistent top bar across Home/Layanan/Berita.

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                SizedBox(height: 8),
                HomeBanner(),
                SizedBox(height: 12),
              ],
            ),
          ),

          // CTA WhatsApp
          SliverToBoxAdapter(
            child: Column(
              children: [
                whatsapp(),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Menu utama
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SectionHeader(title: 'Layanan Utama'),
                const SizedBox(height: 4),
                Categories(),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // PPID banner + Radio
          SliverToBoxAdapter(
            child: Column(
              children: const [
                SectionHeader(title: 'Informasi Publik'),
                ppidBanner(),
                SizedBox(height: 8),
                // Not const: HomePlayer is stateful; add without const
              ],
            ),
          ),
          SliverToBoxAdapter(child: HomePlayer()),

          // Berita
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                SectionHeader(title: 'Berita Terkini'),
                HomeDescription(),
                SizedBox(height: 8),
              ],
            ),
          ),
          // Not const: HomeCaraousel likely stateful
          SliverToBoxAdapter(child: HomeCaraousel()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
