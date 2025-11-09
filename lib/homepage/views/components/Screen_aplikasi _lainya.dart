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
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/antrianPuskes.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/antrianRS.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/awaksigap.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/esayur.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/madiuntoday.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/ppid.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class LayananPage extends StatefulWidget {
  const LayananPage({Key? key}) : super(key: key);

  @override
  State<LayananPage> createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layanan'),
        centerTitle: true,
      ),
      body: Semuaaplikasi(), // Reuse the existing Semuaaplikasi widget
    );
  }
}

class Semuaaplikasi extends StatefulWidget {
  const Semuaaplikasi({Key? key});

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0, // Menghilangkan bayangan di bawah AppBar
        title: Text(
          'Aplikasi Kota Madiun',
          style: TextStyle(
            color: Colors.black, // Warna teks judul
            fontSize: 20, // Ukuran teks judul
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined, // Icon untuk menu navigasi
            color: Colors.black, // Warna ikon
          ),
          onPressed: () {
            Navigator.pop(context);
            // Aksi ketika ikon menu diklik
          },
        ),
        actions: const [],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: const [
              Colors.white,
              Colors.white,
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Cari Aplikasi',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 20.0),
            _tittlelayananasn(),
            SizedBox(height: 20.0),
            _applayananasn(context),
            SizedBox(height: 20.0),
            _tittlelayananpublik(),
            SizedBox(height: 20.0),
            _applayananpublik(context),
            SizedBox(height: 20.0),
            _tittlelayananpengduan(),
            SizedBox(height: 20.0),
            _applayananpengaduan(context),
            SizedBox(height: 20.0),
            _tittlelayanankesehatan(),
            SizedBox(height: 20.0),
            _applayanankesehatan(context),
            SizedBox(height: 20.0),
            _tittlelayananinformasi(),
            SizedBox(height: 20.0),
            _applayananinformasi(context),
            SizedBox(height: 10.0)
          ],
        ),
      ),
    );
  }

  // Widget _tittlepage() dan Widget _beranda() tidak berubah

  Widget _tittlelayananasn() {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.05;
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.api),
          onPressed: () {
            // Aksi ketika tombol "arrow_back" diklik
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0, left: 4.0),
        ),
        Text(
          "LAYANAN ASN",
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
        "page": webspbe(),
      },
      {
        "icon": "assets/images/imgicon/jdih.png",
        "text": "J.D.I.H",
        "page": webjdih(),
      },
      // {
      //   "icon": "assets/images/imgicon/digiform.png",
      //   "text": "DIGIFORM DUKCAPIL",
      //   "page": webdigiform(),
      // },

      {
        "icon": "assets/images/imgicon/emonev.png",
        "text": "EMONEV",
        "page": webemonev(),
      },
      // {
      //   "icon": "assets/images/imgicon/esurat.png",
      //   "text": "ESURAT",
      //   "page": webesurat(),
      // },
      {
        "icon": "assets/images/imgicon/manekin.png",
        "text": "MANEKIN",
        "page": webmanekin(),
      },
      // {
      //   "icon": "assets/images/imgicon/manpro.png",
      //   "text": "MANPRO",
      //   "page": webmanpro(),
      // },
      // {
      //   "icon": "assets/images/imgicon/skp.png",
      //   "text": "SKP",
      //   "page": webskp(),
      // },
      // {
      //   "icon": "assets/images/imgicon/simpeg.png",
      //   "text": "SIMPEG",
      //   "page": websimpeg(),
      // },

      {
        "icon": "assets/images/imgicon/carehub.png",
        "text": "CAREHUB",
        "page": webcarehub(),
      },

      {
        "icon": "assets/images/imgicon/dinsos.png",
        "text": "DINSOS APP",
        "page": webdinsosapp(),
      },
      {
        "icon": "assets/images/imgicon/proumkm.png",
        "text": "PROUMKM",
        "appId": "com.kominfo.proumkm",
        "uriScheme": "proumkm://",
      },

      // {
      //   "icon": "assets/images/imgicon/esakip.png",
      //   "text": "ESAKIP",
      //   "page": webesakip(),
      // },

      // {
      //   "icon": "assets/images/imgicon/exec.png",
      //   "text": "EXECUTIVE SUMMARY",
      //   "page": webexec(),
      // },

      {
        "icon": "assets/images/imgicon/lppd.png",
        "text": "LPPD",
        "page": weblppd(),
      },

      // {
      //   "icon": "assets/images/imgicon/matawarga.png",
      //   "text": "MATAWARGA",
      //   "page": webmatawarga(),
      // },

      // {
      //   "icon": "assets/images/imgicon/puskesos.png",
      //   "text": "PUSKESOS",
      //   "page": webpuskesos(),
      // },
      {
        "icon": "assets/images/imgicon/retribusi.png",
        "text": "RETRIBUSI",
        "page": webretribusi(),
      },
      {
        "icon": "assets/images/imgicon/ruangrapat.png",
        "text": "RUANG RAPAT",
        "page": webruangrapat(),
      },

      // {
      //   "icon": "assets/images/imgicon/simandor.png",
      //   "text": "SIMANDOR",
      //   "page": websimandor(),
      // },
      {
        "icon": "assets/images/imgicon/simonev.png",
        "text": "SIMONEV",
        "page": websimonev(),
      },
      {
        "icon": "assets/images/imgicon/siopa.png",
        "text": "SIOPA",
        "page": websiopa(),
      },

      {
        "icon": "assets/images/imgicon/silandep.png",
        "text": "SILANDEP",
        "page": websilandep(),
      },

      {
        "icon": "assets/images/imgicon/sitebas.png",
        "text": "SITEBAS",
        "page": websitebas(),
      },
    ];

    Future<void> launchPlayStore(String appId) async {
      String playStoreUrl =
          'https://play.google.com/store/apps/details?id=$appId';
      await launch(playStoreUrl);
    }

    void openApp(String appId, String uriScheme) async {
      if (await canLaunch(uriScheme)) {
        await launch(uriScheme);
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
        IconButton(
          icon: Icon(Icons.api),
          onPressed: () {
            // Aksi ketika tombol "arrow_back" diklik
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0, left: 4.0),
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
      // +++++++++++++++++++++++APP layanan Publik +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      // {
      //   "icon": "assets/images/imgicon/ewaris.png",
      //   "text": "EWARIS",
      //   "page": webewaris(),
      // },
      {
        "icon": "assets/images/imgicon/pasaremadiun.png",
        "text": "PASAR E-MADIUN",
        "appId": "com.kominfo.pasar_emadiun",
        "uriScheme": "com.kominfo.pasar_emadiun://",
      },
      // {
      //   "icon": "assets/images/imgicon/pecel.png",
      //   "text": "PECEL TUMPANG",
      //   "page": WebPecel(),
      // },

      // {
      //   "icon": "assets/images/imgicon/sipdok.png",
      //   "text": "SIPDOK",
      //   "page": websipdok(),
      // },
      // {
      //   "icon": "assets/images/imgicon/beasiswa.png",
      //   "text": "BEASISWA MAHASISWA",
      //   "page": webbeasiswa(),
      // },
      {
        "icon": "assets/images/imgicon/bookingprc.png",
        "text": "Booking PRC",
        "appId": "com.kominfo.bookingprc",
        "uriScheme": "bookingprc://",
      },
      {
        "icon": "assets/images/imgicon/esayur.png",
        "text": "ESAYUR",
        "page": webesayur(),
      },
      // {
      //   "icon": "assets/images/imgicon/sicaker.png",
      //   "text": "SICAKER",
      //   "page": websicaker(),
      // },
    ];

    Future<void> launchPlayStore(String appId) async {
      String playStoreUrl =
          'https://play.google.com/store/apps/details?id=$appId';
      await launch(playStoreUrl);
    }

    void openApp(String appId, String uriScheme) async {
      if (await canLaunch(uriScheme)) {
        await launch(uriScheme);
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
        IconButton(
          icon: Icon(Icons.api),
          onPressed: () {
            // Aksi ketika tombol "arrow_back" diklik
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0, left: 4.0),
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
      // +++++++++++++++++++++++APP layanan pengaduan +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      {
        "icon": "assets/images/imgicon/wbs.png",
        "text": "WBS KOTA MADIUN",
        "page": webwbs(),
      },
      // {
      //   "icon": "assets/images/imgicon/aspirasirakyat.png",
      //   "text": "ASPIRASI RAKYAT",
      //   "page": webaspirasirakyat(),
      // },
      {
        "icon": "assets/images/imgicon/awaksigap.png",
        "text": "AWAK SIGAP",
        "page": webawaksigap(),
      },

      {
        "icon": "assets/images/imgicon/ppid.png",
        "text": "PPID",
        "page": webppid(),
      },
    ];

    Future<void> launchPlayStore(String appId) async {
      String playStoreUrl =
          'https://play.google.com/store/apps/details?id=$appId';
      await launch(playStoreUrl);
    }

    void openApp(String appId, String uriScheme) async {
      if (await canLaunch(uriScheme)) {
        await launch(uriScheme);
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
        IconButton(
          icon: Icon(Icons.api),
          onPressed: () {
            // Aksi ketika tombol "arrow_back" diklik
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0, left: 4.0),
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
      // +++++++++++++++++++++++APP layanan pengaduan +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      // {
      //   "icon": "assets/images/imgicon/sipdok.png",
      //   "text": "SIPDOK",
      //   "page": websipdok(),
      // },
      {
        "icon": "assets/images/imgicon/rumahsakit.png",
        "text": "ANTRIAN RUMAH SAKIT",
        "page": webantrianrs()
      },
      {
        "icon": "assets/images/imgicon/puskesmas.png",
        "text": "ANTRIAN PUSKESMAS",
        "page": webantrianpuskes()
      },
    ];

    Future<void> launchPlayStore(String appId) async {
      String playStoreUrl =
          'https://play.google.com/store/apps/details?id=$appId';
      await launch(playStoreUrl);
    }

    void openApp(String appId, String uriScheme) async {
      if (await canLaunch(uriScheme)) {
        await launch(uriScheme);
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
        IconButton(
          icon: Icon(Icons.api),
          onPressed: () {
            // Aksi ketika tombol "arrow_back" diklik
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0, left: 4.0),
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
      // +++++++++++++++++++++++APP layanan pengaduan +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      {
        "icon": "assets/images/imgicon/analisaberita.png",
        "text": "ANALISA BERITA",
        "page": webanalisaberita(),
      },

      // {
      //   "icon": "assets/images/imgicon/edu.png",
      //   "text": "EDU",
      //   "page": WebEdu(),
      // },
      {
        "icon": "assets/images/imgicon/madiuntoday.png",
        "text": "MADIUNTODAY",
        "page": webmadiuntoday(),
      },
      {
        "icon": "assets/images/imgicon/sicakep.png",
        "text": "AGENDA KOTA MADIUN",
        "page": websicakep(),
      },
    ];

    Future<void> launchPlayStore(String appId) async {
      String playStoreUrl =
          'https://play.google.com/store/apps/details?id=$appId';
      await launch(playStoreUrl);
    }

    void openApp(String appId, String uriScheme) async {
      if (await canLaunch(uriScheme)) {
        await launch(uriScheme);
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
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(10),
        height: getProportionateScreenWidth(10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Sudut melengkung
              ),
              elevation: 5, // Bayangan untuk efek 3D
              shadowColor: Colors.black.withOpacity(1), // Warna bayangan
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                height: screenHeight * 0.08,
                width: screenWidth * 0.22,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Colors.blueAccent,
                      Colors.greenAccent
                    ], // Gradasi warna biru
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    icon,
                    width: getProportionateScreenWidth(70),
                    height: getProportionateScreenWidth(70),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _appwargasanCard extends StatelessWidget {
//   const _appwargasanCard({
//     Key? key,
//     required this.icon,
//     required this.text,
//     required this.press,
//   }) : super(key: key);

//   final String icon, text;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     double fontSize = screenWidth * 0.032;
//     return GestureDetector(
//       onTap: press,
//       child: Container(
//         width: getProportionateScreenWidth(10),
//         height: getProportionateScreenWidth(10),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(getProportionateScreenWidth(10)),
//               width: getProportionateScreenWidth(80),
//               height: getProportionateScreenWidth(70),
//               decoration: BoxDecoration(
//                 color: hThirdColor.withOpacity(0.5),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Center(
//                 child: Image.asset(
//                   icon,
//                   width: getProportionateScreenWidth(70),
//                   height: getProportionateScreenWidth(70),
//                 ),
//               ),
//             ),
//             SizedBox(height: 5),
//             Expanded(
//               child: Text(
//                 text,
//                 textAlign: TextAlign.center,
//                 style:
//                     TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
