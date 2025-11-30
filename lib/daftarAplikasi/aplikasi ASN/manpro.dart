import 'package:flutter/material.dart';
import 'package:pendekar/utils/web_container_page.dart';
import 'package:pendekar/utils/services/app_config.dart';

class WebManpro extends StatelessWidget {
  const WebManpro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWebViewPage(
      url: AppConfig.getAsnAppUrl('manpro'),
      title: 'ManPro',
    );
  }
}
