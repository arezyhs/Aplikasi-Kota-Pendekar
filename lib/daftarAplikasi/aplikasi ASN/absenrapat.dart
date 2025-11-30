import 'package:flutter/material.dart';
import 'package:pendekar/utils/web_container_page.dart';
import 'package:pendekar/utils/services/app_config.dart';

class WebAbsenrapat extends StatelessWidget {
  const WebAbsenrapat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWebViewPage(
      url: AppConfig.getAsnAppUrl('absenrapat'),
      title: 'Absen Rapat',
      onLoadComplete: () {
        debugPrint('Absen Rapat loaded successfully');
      },
      onError: (error) {
        debugPrint('Error loading Absen Rapat: $error');
      },
    );
  }
}