import 'package:flutter/material.dart';
import 'package:pendekar/utils/web_container_page.dart';

class WebCctv extends StatelessWidget {
  const WebCctv({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseWebViewPage(
      url: 'http://103.149.120.205/cctv/',
      title: 'CCTV',
    );
  }
}
