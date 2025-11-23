// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pendekar/constants/navigation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class WebPpkm extends StatefulWidget {
  const WebPpkm({Key? key}) : super(key: key);

  @override
  _WebPpkmState createState() => _WebPpkmState();
}

class _WebPpkmState extends State<WebPpkm> {
  bool isLoading = true;
  InAppWebViewController? _webViewController;
  final String url = 'https://ppkm.madiunkota.go.id/login';

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
      debugPrint('Permission to access camera is denied');
    }
    if (statuses[Permission.storage]?.isGranted == false) {
      debugPrint('Permission to access storage is denied');
    }
    if (statuses[Permission.photos]?.isGranted == false) {
      debugPrint('Permission to access photos is denied');
    }
    if (statuses[Permission.mediaLibrary]?.isGranted == false) {
      debugPrint('Permission to access media library is denied');
    }
    if (statuses[Permission.accessMediaLocation]?.isGranted == false) {
      debugPrint('Permission to access media location is denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('PPKM',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
              tooltip: 'Muat Ulang',
              icon: const Icon(Icons.refresh, color: Colors.black54),
              onPressed: () => _webViewController?.reload()),
          IconButton(
              tooltip: 'Buka di Browser',
              icon: const Icon(Icons.open_in_new, color: Colors.black54),
              onPressed: () async {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: WebUri(url)),
                    initialSettings: InAppWebViewSettings(
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
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    onPermissionRequest: (InAppWebViewController controller,
                        PermissionRequest request) async {
                      final ctx = navigatorKey.currentContext;
                      final granted = await showDialog<bool>(
                        context: ctx ?? context,
                        builder: (BuildContext dialogContext) => AlertDialog(
                          title: const Text("Permintaan Izin"),
                          content: const Text(
                              "Ijinkan aplikasi mengakses foto dan media?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop(true);
                              },
                              child: const Text("Izinkan Akses"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop(false);
                              },
                              child: const Text("Tolak Akses"),
                            ),
                          ],
                        ),
                      );

                      final allow = granted ?? false;
                      return PermissionResponse(
                          resources: request.resources,
                          action: allow
                              ? PermissionResponseAction.GRANT
                              : PermissionResponseAction.DENY);
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
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
