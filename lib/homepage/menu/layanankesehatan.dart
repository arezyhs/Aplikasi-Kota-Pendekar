// ignore_for_file: prefer_const_constructors, unused_field, camel_case_types, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/antrian_puskesmas.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/antrian_rs.dart';
import 'package:url_launcher/url_launcher.dart';

class LayananKesehatan extends StatefulWidget {
  const LayananKesehatan({super.key});

  @override
  State<LayananKesehatan> createState() => _LayananKesehatanState();
}

class _LayananKesehatanState extends State<LayananKesehatan> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _searchText = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: isDark
                ? [
                    const Color(0xFF1A1A1A),
                    const Color(0xFF121212),
                  ]
                : const [
                    Color(0xFFF7F9FC),
                    Color(0xFFFFFFFF),
                  ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 8.0),
            TextField(
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
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 16.0),
            _applayanankesehatan(context),
          ],
        ),
      ),
    );
  }

  Widget _applayanankesehatan(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      // +++++++++++++++++++++++APP layanan pengaduan +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      // {
      //   "icon": "assets/images/imgicon/sipdok.png",
      //   "text": "SIPDOK",
      //   "page": websipdok(),
      // },
      {
        "icon": "assets/images/imgicon/rumahsakit.png",
        "text": "ANTRIAN RUMAH SAKIT",
        "page": WebAntrianRS(),
      },
      {
        "icon": "assets/images/imgicon/puskesmas.png",
        "text": "ANTRIAN PUSKESMAS",
        "page": WebAntrianPuskesmas(),
      },
    ];

    Future<void> launchPlayStore(String appId) async {
      String playStoreUrl =
          'https://play.google.com/store/apps/details?id=$appId';
      final Uri playStoreUri = Uri.parse(playStoreUrl);
      await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
    }

    void openApp(String appId, String uriScheme) async {
      final Uri uri = Uri.parse(uriScheme);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchPlayStore(appId);
      }
    }

    // Filter categories berdasarkan _searchText
    List<Map<String, dynamic>> filteredCategories = categories
        .where((category) =>
            category['text'].toString().toLowerCase().contains(_searchText))
        .toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) => _berandaCard(
        icon: filteredCategories[index]["icon"],
        text: filteredCategories[index]["text"],
        press: () {
          if (filteredCategories[index].containsKey("appId") &&
              filteredCategories[index].containsKey("uriScheme")) {
            openApp(
              filteredCategories[index]["appId"],
              filteredCategories[index]["uriScheme"],
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => filteredCategories[index]["page"],
              ),
            );
          }
        },
      ),
    );
  }
}

class _berandaCard extends StatelessWidget {
  const _berandaCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: press,
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
                  color: Theme.of(context).shadowColor.withAlpha(15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                icon,
                width: screenWidth * 0.14,
                height: screenWidth * 0.14,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
