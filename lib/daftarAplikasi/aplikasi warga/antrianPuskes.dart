// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

class webantrianpuskes extends StatefulWidget {
  const webantrianpuskes({Key? key}) : super(key: key);

  @override
  _webantrianpuskesState createState() => _webantrianpuskesState();
}

class _webantrianpuskesState extends State<webantrianpuskes> {
  bool isLoading = true;
  InAppWebViewController? _webViewController;
  final String url = 'https://dinkes.madiunkota.go.id/web/';

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> requestPermissions() async {
    // Meminta izin di sini
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
      Permission.mediaLibrary,
      Permission.accessMediaLocation,
    ].request();

    // Cek apakah izin diberikan atau tidak
    if (statuses[Permission.camera]?.isGranted == false) {
      print('Permission to access camera is denied');
    }
    if (statuses[Permission.storage]?.isGranted == false) {
      print('Permission to access storage is denied');
    }
    if (statuses[Permission.photos]?.isGranted == false) {
      print('Permission to access photos is denied');
    }
    if (statuses[Permission.mediaLibrary]?.isGranted == false) {
      print('Permission to access media library is denied');
    }
    if (statuses[Permission.accessMediaLocation]?.isGranted == false) {
      print('Permission to access media location is denied');
    }
  }

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
                    initialUrlRequest: URLRequest(url: WebUri(url)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        clearCache: false,
                        cacheEnabled: true,
                        transparentBackground: true,
                        supportZoom: true,
                        useOnDownloadStart: true,
                        mediaPlaybackRequiresUserGesture: false,
                        allowFileAccessFromFileURLs: true,
                        allowUniversalAccessFromFileURLs: true,
                        javaScriptCanOpenWindowsAutomatically: true,
                        javaScriptEnabled: true,
                      ),
                      android: AndroidInAppWebViewOptions(
                        useHybridComposition: true,
                        allowContentAccess: true,
                        allowFileAccess: true,
                      ),
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    androidOnPermissionRequest:
                        (InAppWebViewController controller, String origin,
                            List<String> resources) async {
                      var response = await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Permintaan Izin"),
                          content: Text(
                              "Ijinkan aplikasi mengakses foto dan media?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(PermissionRequestResponseAction.GRANT);
                              },
                              child: Text("Izinkan Akses"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(PermissionRequestResponseAction.DENY);
                              },
                              child: Text("Tolak Akses"),
                            ),
                          ],
                        ),
                      );

                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    // Event lainnya di sini
                    onLoadStop: (controller, url) async {
                      setState(() {
                        isLoading = false;
                      });
                      // Menggunakan JavaScript untuk menyembunyikan elemen yang tidak diinginkan
                      //           controller.evaluateJavascript(source: '''
                      //             var element = document.getElementsByClassName('navbar')[0];
                      //   if (element != null) {
                      //     element.style.display = 'none';
                      //   }
                      //    var sideMenu = document.getElementsByClassName('toolbar')[0];
                      //   if (sideMenu != null) {
                      //     sideMenu.style.display = 'none';
                      //   }
                      //   var header = document.getElementsByClassName('account-masthead')[0];
                      //   if (header != null) {
                      //     header.style.display = 'none';
                      //   }
                      //   var footer = document.getElementsByClassName('footer pt-5')[0];
                      //   if (footer != null) {
                      //     footer.style.display = 'none';
                      //   }
                      //   var second = document.getElementsByClassName('secondary col-md-3')[0];
                      //   if (second != null) {
                      //     second.style.display = 'none';
                      //   }

                      // ''');
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
