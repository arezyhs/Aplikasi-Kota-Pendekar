// ignore_for_file: prefer_const_constructors, unused_field, camel_case_types, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/esayur.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class LayananPublik extends StatefulWidget {
  const LayananPublik({super.key});

  @override
  State<LayananPublik> createState() => _LayananPublikState();
}

class _LayananPublikState extends State<LayananPublik> {
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
            _tittlelayananpengduan(),
            SizedBox(height: 20.0),
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
            _applayananpublik(context),
          ],
        ),
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

      {
        "icon": "assets/images/imgicon/pasaremadiun.png",
        "text": "PASAR E-MADIUN",
        "appId": "com.kominfo.pasar_emadiun",
        "uriScheme": "com.kominfo.pasar_emadiun://",
      },

      // {
      //   "icon": "assets/images/imgicon/beasiswa.png",
      //   "text": "BEASISWA MAHASISWA",
      //   "page": webbeasiswa(),
      // },

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
              shadowColor: Colors.black.withOpacity(1), // Warna bayangan
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                height: screenHeight * 0.08,
                width: screenWidth * 0.20,
                decoration: BoxDecoration(
                  color: hThirdColor.withOpacity(0.5),
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
