import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pendekar/constants/layanan_data.dart';
import 'package:pendekar/models/layanan_category.dart';
import 'package:pendekar/widgets/layanan_widgets.dart';

// Generic screen untuk menampilkan kategori layanan
// Digunakan oleh semua menu (ASN, Publik, Pengaduan, Kesehatan, Informasi)
class CategoryMenuScreen extends StatelessWidget {
  final String categoryId;
  final String title;

  const CategoryMenuScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final category = LayananData.categories.firstWhere(
      (cat) => cat.id == categoryId,
      orElse: () => LayananCategory(
        id: categoryId,
        title: title,
        icon: Icons.apps,
        apps: [],
      ),
    );

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 239, 245, 248),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 45, 95, 131)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 239, 245, 248),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: category.apps.isEmpty
            ? const Center(child: Text('Tidak ada layanan'))
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: screenWidth * 0.02,
                  mainAxisSpacing: screenWidth * 0.02,
                  childAspectRatio: 0.85,
                ),
                itemCount: category.apps.length,
                itemBuilder: (context, index) {
                  final app = category.apps[index];
                  return AppCard(
                    icon: app.icon,
                    text: app.text,
                    onTap: () => _handleAppTap(context, app),
                  );
                },
              ),
      ),
    );
  }

  Future<void> _handleAppTap(BuildContext context, LayananApp app) async {
    if (app.page != null) {
      // Internal navigation
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => app.page!),
      );
    } else if (app.appId != null && app.uriScheme != null) {
      // External app launch
      final Uri uri = Uri.parse(app.uriScheme!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Aplikasi ${app.text} tidak terpasang'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
