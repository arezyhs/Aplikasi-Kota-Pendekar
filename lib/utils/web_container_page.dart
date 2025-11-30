// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pendekar/utils/helpers/colorhelper.dart';

/// Base WebView widget yang dapat digunakan oleh semua aplikasi
class BaseWebViewPage extends StatefulWidget {
  final String url;
  final String title;
  final bool showAppBar;
  final List<Widget>? additionalActions;
  final VoidCallback? onLoadComplete;
  final Function(String)? onError;

  const BaseWebViewPage({
    Key? key,
    required this.url,
    required this.title,
    this.showAppBar = true,
    this.additionalActions,
    this.onLoadComplete,
    this.onError,
  }) : super(key: key);

  @override
  State<BaseWebViewPage> createState() => _BaseWebViewPageState();
}

class _BaseWebViewPageState extends State<BaseWebViewPage> {
  bool isLoading = true;
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
        Permission.photos,
        Permission.mediaLibrary,
        Permission.accessMediaLocation,
      ].request();

      // Log denied permissions for debugging
      statuses.forEach((permission, status) {
        if (status.isDenied) {
          debugPrint('Permission ${permission.toString()} denied');
        }
      });
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
    }
  }

  Future<void> _openInExternalBrowser() async {
    try {
      final uri = Uri.parse(widget.url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tidak dapat membuka di browser eksternal'),
          backgroundColor: ColorHelper.errorColor,
        ),
      );
    }
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: ColorHelper.loadingColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Memuat ${widget.title}...',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    List<Widget> actions = [
      IconButton(
        tooltip: 'Muat Ulang',
        icon: const Icon(Icons.refresh, color: Colors.black54),
        onPressed: () => _webViewController?.reload(),
      ),
      IconButton(
        tooltip: 'Buka di Browser',
        icon: const Icon(Icons.open_in_new, color: Colors.black54),
        onPressed: _openInExternalBrowser,
      ),
    ];

    if (widget.additionalActions != null) {
      actions.insertAll(0, widget.additionalActions!);
    }

    return actions;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.showAppBar
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black87),
              title: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: _buildAppBarActions(),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            if (widget.showAppBar) SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: WebUri(widget.url)),
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
                    onPermissionRequest: (controller, request) async {
                      return PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT,
                      );
                    },
                    onLoadStop: (controller, url) async {
                      setState(() {
                        isLoading = false;
                      });
                      widget.onLoadComplete?.call();
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                  ),
                  if (isLoading) _buildLoadingWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
