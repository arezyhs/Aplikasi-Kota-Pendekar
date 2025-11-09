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
          SliverAppBar(
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Aplikasi Kota Pendekar',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
            ),
            centerTitle: false,
            actions: const [SizedBox(width: 8)],
            iconTheme: const IconThemeData(color: Colors.black87),
          ),

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
