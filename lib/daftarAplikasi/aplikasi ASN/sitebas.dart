// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pendekar/constants/navigation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class WebSitebas extends StatefulWidget {
  const WebSitebas({Key? key}) : super(key: key);

  @override
  _WebSitebasState createState() => _WebSitebasState();
}

class _WebSitebasState extends State<WebSitebas> {
  bool isLoading = true;
  InAppWebViewController? _webViewController;
  final String url = 'https://sitebas.madiunkota.go.id/';

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
      Permission.mediaLibrary,
      Permission.accessMediaLocation,
    ].request();

    if (statuses[Permission.camera]?.isGranted == false) {
      debugPrint('Permission to access camera is denied');
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
        title: const Text('Sitebas',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            tooltip: 'Muat Ulang',
            icon: const Icon(Icons.refresh, color: Colors.black54),
            onPressed: () => _webViewController?.reload(),
          ),
          IconButton(
            tooltip: 'Buka di Browser',
            icon: const Icon(Icons.open_in_new, color: Colors.black54),
            onPressed: () async {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
          ),
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
                            : PermissionResponseAction.DENY,
                      );
                    },
                    onLoadStart: (controller, uri) {
                      setState(() => isLoading = true);
                    },
                    onLoadStop: (controller, uri) async {
                      setState(() => isLoading = false);
                    },
                  ),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator()),
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
