import 'package:flutter/material.dart';
import 'package:pendekar/utils/web_container_page.dart';
import 'package:pendekar/utils/services/app_config.dart';

class WebSpbe extends StatelessWidget {
  const WebSpbe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWebViewPage(
      url: AppConfig.getAsnAppUrl('buktidukungspbe'),
      title: 'Bukti Dukung SPBE',
    );
  }
}
