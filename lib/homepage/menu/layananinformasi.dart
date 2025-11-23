// ignore_for_file: prefer_const_constructors, unused_field, camel_case_types, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/jdih.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/sicakep.dart';
// import 'package:pendekar/daftarAplikasi/aplikasi%20warga/edu.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/madiuntoday.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/opendata.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class LayananInformasi extends StatefulWidget {
  const LayananInformasi({super.key});

  @override
  State<LayananInformasi> createState() => _LayananInformasiState();
}

class _LayananInformasiState extends State<LayananInformasi> {
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
            _tittlelayananInformasi(),
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
            _applayananInformasi(context),
          ],
        ),
      ),
    );
  }

  // Widget _tittlepage() dan Widget _beranda() tidak berubah

  Widget _tittlelayananInformasi() {
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

  Widget _applayananInformasi(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      // +++++++++++++++++++++++APP layanan pengaduan +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      {
        "icon": "assets/images/imgicon/sicakep.png",
        "text": "AGENDA KOTA MADIUN",
        "page": WebSicakep(),
      },

      // {
      //   "icon": "assets/images/imgicon/edu.png",
      //   "text": "EDU",
      //   "page": WebEdu(),
      // },
      {
        "icon": "assets/images/imgicon/madiuntoday.png",
        "text": "MADIUNTODAY",
        "page": WebMadiuntoday(),
      },
      {
        "icon": "assets/images/imgicon/opendata.png",
        "text": "Open Data",
        "page": OpenData(),
      },
      {
        "icon": "assets/images/imgicon/jdih.png",
        "text": "JDIH",
        "page": WebJdih(),
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
