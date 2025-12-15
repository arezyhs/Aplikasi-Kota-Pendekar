// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_new, sort_child_properties_last, non_constant_identifier_names, unused_local_variable, use_key_in_widget_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/analisaberita.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/buktidukungspbe.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/carehub.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/dinsosapp.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/emonev.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/jdih.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/lppd.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/manekin.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/retribusi.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/ruangrapat.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/sicakep.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/silandep.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/simonev.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/siopa.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/sitebas.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/wbs.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/antrian_puskesmas.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/antrian_rs.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/awaksigap.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/esayur.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/madiuntoday.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/ppid.dart';
// removed unused import: size_config
import 'package:url_launcher/url_launcher.dart';

class LayananPage extends StatefulWidget {
  const LayananPage({Key? key}) : super(key: key);

  @override
  State<LayananPage> createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  @override
  Widget build(BuildContext context) {
    // Return only the page content. The top AppBar is provided by the main
    // shell (HomePage) to keep headers consistent across tabs.
    return const Semuaaplikasi();
  }
}

class Semuaaplikasi extends StatefulWidget {
  const Semuaaplikasi({Key? key}) : super(key: key);

  @override
  State<Semuaaplikasi> createState() => _SemuaaplikasiState();
}

class _SemuaaplikasiState extends State<Semuaaplikasi> {
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
    // Return a body only (we already have an AppBar in the parent LayananPage)
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: const [
            Color(0xFFF7F9FC),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ListView(
        children: <Widget>[
          // top spacing — AppBar now provides the page title
          const SizedBox(height: 8.0),

          // Search field
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari aplikasi...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
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
          const SizedBox(height: 20.0),

          // Sections
          _tittlelayananpublik(),
          const SizedBox(height: 12.0),
          _applayananpublik(context),
          const SizedBox(height: 18.0),

          _tittlelayananpengduan(),
          const SizedBox(height: 12.0),
          _applayananpengaduan(context),
          const SizedBox(height: 18.0),

          _tittlelayanankesehatan(),
          const SizedBox(height: 12.0),
          _applayanankesehatan(context),
          const SizedBox(height: 18.0),

          _tittlelayananinformasi(),
          const SizedBox(height: 12.0),
          _applayananinformasi(context),
          const SizedBox(height: 18.0),

          _tittlelayananasn(),
          const SizedBox(height: 12.0),
          _applayananasn(context),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  // Widget _tittlepage() dan Widget _beranda() tidak berubah

  Widget _tittlelayananasn() {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.05;
    return Row(
      children: <Widget>[
        // decorative leading icon (not a back button)
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.apps,
            color: Colors.black54,
            size: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 4.0),
        ),
        Text(
          "Layanan ASN",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 11, 11, 11),
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _applayananasn(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      // Data aplikasi
//+++++++++++++++++++++++APP ASN +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      {
        "icon": "assets/images/imgicon/ekinerja.png",
        "text": "EKINERJA ",
        "appId": "gov.madiun.ekin_madiun_andro",
        "uriScheme": "ekinerja://",
      },

      {
        "icon": "assets/images/imgicon/buktidukungspbe.png",
        "text": "BUKTI DUKUNG SPBE",
        "page": WebSpbe(),
      },
      {
        "icon": "assets/images/imgicon/jdih.png",
        "text": "J.D.I.H",
        "page": WebJdih(),
      },
      {
        "icon": "assets/images/imgicon/emonev.png",
        "text": "EMONEV",
        "page": WebEmonev(),
      },
      {
        "icon": "assets/images/imgicon/manekin.png",
        "text": "MANEKIN",
        "page": WebManekin(),
      },
      {
        "icon": "assets/images/imgicon/carehub.png",
        "text": "CAREHUB",
        "page": WebCarehub(),
      },

      {
        "icon": "assets/images/imgicon/dinsos.png",
        "text": "DINSOS APP",
        "page": WebDinsosapp(),
      },
      {
        "icon": "assets/images/imgicon/proumkm.png",
        "text": "PROUMKM",
        "appId": "com.kominfo.proumkm",
        "uriScheme": "proumkm://",
      },
      {
        "icon": "assets/images/imgicon/lppd.png",
        "text": "LPPD",
        "page": WebLppd(),
      },
      {
        "icon": "assets/images/imgicon/retribusi.png",
        "text": "RETRIBUSI",
        "page": WebRetribusi(),
      },
      {
        "icon": "assets/images/imgicon/ruangrapat.png",
        "text": "RUANG RAPAT",
        "page": WebRuangrapat(),
      },
      {
        "icon": "assets/images/imgicon/simonev.png",
        "text": "SIMONEV",
        "page": WebSimonev(),
      },
      {
        "icon": "assets/images/imgicon/siopa.png",
        "text": "SIOPA",
        "page": WebSiopa(),
      },
      {
        "icon": "assets/images/imgicon/silandep.png",
        "text": "SILANDEP",
        "page": WebSilandep(),
      },
      {
        "icon": "assets/images/imgicon/sitebas.png",
        "text": "SITEBAS",
        "page": WebSitebas(),
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
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

  Widget _tittlelayananpublik() {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.05;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.public,
            color: Colors.black54,
            size: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 4.0),
        ),
        Text(
          "Layanan Publik",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 11, 11, 11),
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _applayananpublik(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/images/imgicon/pasaremadiun.png",
        "text": "PASAR E-MADIUN",
        "appId": "com.kominfo.pasar_emadiun",
        "uriScheme": "com.kominfo.pasar_emadiun://",
      },
      {
        "icon": "assets/images/imgicon/bookingprc.png",
        "text": "Booking PRC",
        "appId": "com.kominfo.bookingprc",
        "uriScheme": "bookingprc://",
      },
      {
        "icon": "assets/images/imgicon/esayur.png",
        "text": "ESAYUR",
        "page": WebEsayur(),
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

    List<Map<String, dynamic>> filteredCategories = categories
        .where((category) =>
            category['text'].toString().toLowerCase().contains(_searchText))
        .toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 10.0,
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

  Widget _tittlelayananpengduan() {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.05;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.report,
            color: Colors.black54,
            size: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 4.0),
        ),
        Text(
          "Layanan Pengaduan",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 11, 11, 11),
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _applayananpengaduan(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/images/imgicon/wbs.png",
        "text": "WBS KOTA MADIUN",
        "page": WebWbs(),
      },
      {
        "icon": "assets/images/imgicon/awaksigap.png",
        "text": "AWAK SIGAP",
        "page": WebAwaksigap(),
      },
      {
        "icon": "assets/images/imgicon/ppid.png",
        "text": "PPID",
        "page": WebPpid(),
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

    List<Map<String, dynamic>> filteredCategories = categories
        .where((category) =>
            category['text'].toString().toLowerCase().contains(_searchText))
        .toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 10.0,
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

  Widget _tittlelayanankesehatan() {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.05;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.local_hospital,
            color: Colors.black54,
            size: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 4.0),
        ),
        Text(
          "Layanan Kesehatan",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 11, 11, 11),
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _applayanankesehatan(BuildContext context) {
    List<Map<String, dynamic>> categories = [
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

    List<Map<String, dynamic>> filteredCategories = categories
        .where((category) =>
            category['text'].toString().toLowerCase().contains(_searchText))
        .toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 10.0,
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

  Widget _tittlelayananinformasi() {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.05;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.info,
            color: Colors.black54,
            size: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 4.0),
        ),
        Text(
          "Layanan Informasi",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 11, 11, 11),
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _applayananinformasi(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/images/imgicon/analisaberita.png",
        "text": "ANALISA BERITA",
        "page": WebAnalisaberita(),
      },
      {
        "icon": "assets/images/imgicon/madiuntoday.png",
        "text": "MADIUNTODAY",
        "page": WebMadiun(),
      },
      {
        "icon": "assets/images/imgicon/sicakep.png",
        "text": "AGENDA KOTA MADIUN",
        "page": WebSicakep(),
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

    List<Map<String, dynamic>> filteredCategories = categories
        .where((category) =>
            category['text'].toString().toLowerCase().contains(_searchText))
        .toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
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

// =========================================================================================================================================================================================================================
// =========================================================================================================================================================================================================================
// =========================================================================================================================================================================================================================
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
    final screenHeight = MediaQuery.of(context).size.height;

    double fontSize = screenWidth * 0.032;
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenWidth * 0.26,
            // limit height so the card doesn't overflow in tight constraints
            height: screenWidth * 0.18,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 8,
                  offset: Offset(0, 4),
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
          const SizedBox(height: 4),
          SizedBox(
            width: screenWidth * 0.26,
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: fontSize.clamp(10, 14),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
