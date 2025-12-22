// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pendekar/constants/layanan_data.dart';
import 'package:pendekar/models/layanan_category.dart';
import 'package:pendekar/widgets/layanan_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class LayananPage extends StatefulWidget {
  const LayananPage({Key? key}) : super(key: key);

  @override
  State<LayananPage> createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  @override
  Widget build(BuildContext context) {
    return const Semuaaplikasi();
  }
}

class Semuaaplikasi extends StatefulWidget {
  const Semuaaplikasi({Key? key}) : super(key: key);

  @override
  State<Semuaaplikasi> createState() => _SemuaaplikasiState();
}

class _SemuaaplikasiState extends State<Semuaaplikasi> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: isDark
              ? [const Color(0xFF1A1A1A), const Color(0xFF121212)]
              : const [Color(0xFFF7F9FC), Color(0xFFFFFFFF)],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ListView(
        children: [
          const SizedBox(height: 8.0),
          _buildSearchField(),
          const SizedBox(height: 20.0),
          
          // Generate sections dynamically from data
          ...LayananData.categories.map((category) => Column(
            children: [
              SectionHeader(title: category.title, icon: category.icon),
              const SizedBox(height: 12.0),
              _buildAppGrid(category),
              const SizedBox(height: 18.0),
            ],
          )),
          
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari aplikasi...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (value) => setState(() => _searchText = value.toLowerCase()),
    );
  }

  Widget _buildAppGrid(LayananCategory category) {
    // Filter apps based on search text
    final filteredApps = category.apps
        .where((app) => app.text.toLowerCase().contains(_searchText))
        .toList();

    if (filteredApps.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: filteredApps.length,
      itemBuilder: (context, index) {
        final app = filteredApps[index];
        return AppCard(
          icon: app.icon,
          text: app.text,
          onTap: () => _handleAppTap(app),
        );
      },
    );
  }

  void _handleAppTap(LayananApp app) {
    if (app.appId != null && app.uriScheme != null) {
      _openExternalApp(app.appId!, app.uriScheme!);
    } else if (app.page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => app.page),
      );
    }
  }

  Future<void> _openExternalApp(String appId, String uriScheme) async {
    final uri = Uri.parse(uriScheme);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      await _launchPlayStore(appId);
    }
  }

  Future<void> _launchPlayStore(String appId) async {
    final playStoreUrl = 'https://play.google.com/store/apps/details?id=$appId';
    final uri = Uri.parse(playStoreUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
