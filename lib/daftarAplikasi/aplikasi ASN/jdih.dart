// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class webjdih extends StatelessWidget {
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

  const webjdih({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.034;
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
                color: Colors.black.withOpacity(0.3),
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
                                          .withOpacity(1),
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
      MaterialPageRoute(builder: (context) => WebViewPage(url: url)),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? _webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.034;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        javaScriptEnabled: true,
                        clearCache: true,
                        cacheEnabled: true,
                        transparentBackground: true,
                        supportZoom: false,
                        allowFileAccessFromFileURLs: true,
                        allowUniversalAccessFromFileURLs: true,
                      ),
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    onLoadStop: (controller, url) async {
                      setState(() {
                        isLoading = false;
                      });
                      // Menggunakan JavaScript untuk menyembunyikan elemen yang tidak diinginkan
                      controller.evaluateJavascript(source: '''
                        var element = document.getElementsByClassName('navbar')[0];
              if (element != null) {
                element.style.display = 'none';
              }
               var sideMenu = document.getElementsByClassName('toolbar')[0];
              if (sideMenu != null) {
                sideMenu.style.display = 'none';
              }
              var header = document.getElementsByClassName('account-masthead')[0];
              if (header != null) {
                header.style.display = 'none';
              }
              var footer = document.getElementsByClassName('footer pt-5')[0];
              if (footer != null) {
                footer.style.display = 'none';
              }
              var second = document.getElementsByClassName('secondary col-md-3')[0];
              if (second != null) {
                second.style.display = 'none';
              }
             
            ''');
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                  ),
                  if (isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: const Color.fromARGB(255, 6, 97, 94),
                      ),
                    ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Tooltip(
                  message: 'Kembali Ke Menu',
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 6, 97, 94),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 2,
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.home, color: Colors.white),
                        Text(
                          'Kembali Ke Menu',
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                Tooltip(
                  message: 'Muat Ulang',
                  child: ElevatedButton(
                    onPressed: () {
                      if (_webViewController != null) {
                        _webViewController?.reload();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 6, 97, 94),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 2,
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.refresh, color: Colors.white),
                        Text(
                          'Muat Ulang',
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                Tooltip(
                  message: 'Sebelumnya',
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_webViewController != null) {
                        bool canGoBack = await _webViewController!.canGoBack();
                        if (canGoBack) {
                          _webViewController?.goBack();
                        } else {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 6, 97, 94),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 2,
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white),
                        Text(
                          'Sebelumnya',
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
