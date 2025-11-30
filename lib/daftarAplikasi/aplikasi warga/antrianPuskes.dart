import 'package:flutter/material.dart';
import 'package:pendekar/utils/web_container_page.dart';
import 'package:pendekar/utils/services/app_config.dart';

class WebAntrianPuskesmas extends StatelessWidget {
  const WebAntrianPuskesmas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWebViewPage(
      url: AppConfig.getWargaAppUrl('antriankesehatan'),
      title: 'Antrian Puskesmas',
    );
  }
}
