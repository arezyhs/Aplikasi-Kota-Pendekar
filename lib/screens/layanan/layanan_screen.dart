// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pendekar/constants/layanan_data.dart';
import 'package:pendekar/models/layanan_category.dart';
import 'package:pendekar/widgets/layanan_widgets.dart';
import 'package:pendekar/widgets/layanan_search_widget.dart';
import 'package:pendekar/widgets/layanan_filter_widget.dart';
import 'package:pendekar/constants/constant.dart';
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
  String? _selectedCategory;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
      child: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        children: [
          LayananSearchWidget(
            controller: _searchController,
            searchText: _searchText,
            resultCount: _getTotalResults(),
            onChanged: (value) =>
                setState(() => _searchText = value.toLowerCase()),
            onClear: () {
              _searchController.clear();
              setState(() => _searchText = '');
            },
          ),
          const SizedBox(height: AppSpacing.md),
          LayananFilterWidget(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) =>
                setState(() => _selectedCategory = category),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Generate sections dynamically from data
          ...LayananData.categories
              .where((category) =>
                  _selectedCategory == null || _selectedCategory == category.id)
              .map((category) => Column(
                    children: [
                      SectionHeader(title: category.title, icon: category.icon),
                      const SizedBox(height: AppSpacing.sm),
                      _buildAppGrid(category),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  )),
        ],
      ),
    );
  }

  int _getTotalResults() {
    if (_searchText.isEmpty) return 0;

    return LayananData.categories
        .where((category) =>
            _selectedCategory == null || _selectedCategory == category.id)
        .fold(
            0,
            (sum, category) =>
                sum +
                category.apps
                    .where(
                        (app) => app.text.toLowerCase().contains(_searchText))
                    .length);
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
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
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
