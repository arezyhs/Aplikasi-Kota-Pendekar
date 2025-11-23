// ignore_for_file: prefer_const_constructors, unused_field, camel_case_types, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/buktidukungspbe.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/carehub.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/digiform.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/dinsosapp.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/emonev.dart';
// import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/esakip.dart';
// import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/esurat.dart';
// import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/exec.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/jdih.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/lppd.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/manekin.dart';
// import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/manpro.dart';
// import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/puskesos.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/retribusi.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/ruangrapat.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/silandep.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/simandor.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/simonev.dart';
// import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/simpeg.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/siopa.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/sitebas.dart';
// import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/skp.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/matawarga.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constant.dart';

class LayananAsn extends StatefulWidget {
  const LayananAsn({super.key});

  @override
  State<LayananAsn> createState() => _LayananAsnState();
}

class _LayananAsnState extends State<LayananAsn> {
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.white,
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            _tittlelayananasn(),
            const SizedBox(height: 20.0),
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
            const SizedBox(height: 20.0),
            _applayananasn(context),
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
        "page": WebSpbe(),
      },
      {
        "icon": "assets/images/imgicon/bakul.png",
        "text": "J.D.I.H",
        "page": WebJdih(),
      },
      {
        "icon": "assets/images/imgicon/digiform.png",
        "text": "DIGIFORM DUKCAPIL",
        "page": WebDigiform(),
      },

      {
        "icon": "assets/images/imgicon/emonev.png",
        "text": "EMONEV",
        "page": WebEmonev(),
      },
      // {
      //   "icon": "assets/images/imgicon/esurat.png",
      //   "text": "ESURAT",
      //   "page": webesurat(),
      // },
      {
        "icon": "assets/images/imgicon/manekin.png",
        "text": "MANEKIN",
        "page": WebManekin(),
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
        "page": WebLppd(),
      },

      {
        "icon": "assets/images/imgicon/matawarga.png",
        "text": "MATAWARGA",
        "page": WebMatawarga(),
      },

      // {
      //   "icon": "assets/images/imgicon/puskesos.png",
      //   "text": "PUSKESOS",
      //   "page": webpuskesos(),
      // },
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
        "icon": "assets/images/imgicon/simandor.png",
        "text": "SIMANDOR",
        "page": WebSimandor(),
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
    final screenHeight = MediaQuery.of(context).size.height;

    double fontSize = screenWidth * 0.032;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: getProportionateScreenWidth(10),
        height: getProportionateScreenWidth(10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Sudut melengkung
              ),
              elevation: 5, // Bayangan untuk efek 3D
              shadowColor: Colors.black, // Warna bayangan
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                height: screenHeight * 0.08,
                width: screenWidth * 0.20,
                decoration: BoxDecoration(
                  color: hThirdColor.withAlpha(128),
                  borderRadius: BorderRadius.circular(20),
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
            const SizedBox(height: 5),
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
