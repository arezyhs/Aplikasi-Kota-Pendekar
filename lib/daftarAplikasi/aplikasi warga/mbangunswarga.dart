// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class WebMcm extends StatefulWidget {
  const WebMcm({Key? key}) : super(key: key);

  @override
  _WebMcmState createState() => _WebMcmState();
}

class _WebMcmState extends State<WebMcm> {
  bool isLoading = true;
  InAppWebViewController? _webViewController;
  final String url = 'https://mbangunswarga.madiunkota.go.id/login';

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
    // Request necessary permissions (best-effort)
    await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
      Permission.mediaLibrary,
      Permission.accessMediaLocation,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Mbangun Swarga',
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
            const SizedBox(height: 8),
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
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Permintaan Izin"),
                          content: const Text(
                              "Ijinkan aplikasi mengakses foto dan media?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(PermissionRequestResponseAction.GRANT);
                              },
                              child: const Text("Izinkan Akses"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(PermissionRequestResponseAction.DENY);
                              },
                              child: const Text("Tolak Akses"),
                            ),
                          ],
                        ),
                      );

                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    onLoadStop: (controller, url) async {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                  ),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 6, 97, 94),
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
