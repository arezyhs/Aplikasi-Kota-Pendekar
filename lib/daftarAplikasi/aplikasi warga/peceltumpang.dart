import 'package:flutter/material.dart';
import 'package:pendekar/utils/web_container_page.dart';
import 'package:pendekar/utils/services/app_config.dart';

class WebPecel extends StatelessWidget {
  const WebPecel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWebViewPage(
      url: AppConfig.getWargaAppUrl('peceltumpang'),
      title: 'Pecel Tumpang',
      onLoadComplete: () {
        debugPrint('Pecel Tumpang loaded successfully');
      },
      onError: (error) {
        debugPrint('Error loading Pecel Tumpang: $error');
      },
    );
  }
}