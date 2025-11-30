import 'package:flutter/material.dart';
import 'package:pendekar/utils/web_container_page.dart';
import 'package:pendekar/utils/services/app_config.dart';

class WebSmartcity extends StatelessWidget {
  const WebSmartcity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWebViewPage(
      url: AppConfig.getWargaAppUrl('smartcity'),
      title: 'Smart City',
      onLoadComplete: () {
        debugPrint('Smart City loaded successfully');
      },
      onError: (error) {
        debugPrint('Error loading Smart City: $error');
      },
    );
  }
}
