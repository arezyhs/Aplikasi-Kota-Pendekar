// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:pendekar/utils/web_container_page.dart';

class WebJdih extends StatelessWidget {
  final List<Map<String, String>> cardData = const [
    {
      'name': 'Beranda',
      'url': 'https://jdih.madiunkota.go.id/',
      'image': 'assets/images/jdih/beranda.png'
    },
    {
      'name': 'Profil',
      'url': 'https://jdih.madiunkota.go.id/profil',
      'image': 'assets/images/jdih/profil.png'
    },
    {
      'name': 'Berita',
      'url': 'https://jdih.madiunkota.go.id/berita',
      'image': 'assets/images/jdih/berita.png'
    },
    {
      'name': 'Produk Hukum',
      'url': 'https://jdih.madiunkota.go.id/produk/hukum',
      'image': 'assets/images/jdih/produkhukum.png'
    },
    {
      'name': 'Propemperda',
      'url': 'https://jdih.madiunkota.go.id/propemperda',
      'image': 'assets/images/jdih/propemperda.png'
    },
    {
      'name': 'Bankumaskin',
      'url': 'https://jdih.madiunkota.go.id/bankumaskin',
      'image': 'assets/images/jdih/bankumaskin.png'
    },
  ];

  const WebJdih({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 23, 162, 184),
                Color.fromARGB(255, 23, 162, 184),
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(77),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: const Text(
          "JDIH Kota Madiun",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  padding: EdgeInsets.only(top: screenHeight * 0.002),
                  children: List.generate(cardData.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        _handleCardTap(context, cardData[index]['url']!);
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.020,
                            horizontal: screenWidth * 0.030),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image:
                                        AssetImage(cardData[index]['image']!),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        screenWidth * 0.020,
                                        screenWidth * 0.008,
                                        screenWidth * 0.020,
                                        screenWidth * 0.008),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 23, 162, 184)
                                          .withAlpha(255),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15.0),
                                        bottomRight: Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Text(
                                      cardData[index]['name']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BaseWebViewPage(
          url: url,
          title: 'JDIH',
        ),
      ),
    );
  }
}
