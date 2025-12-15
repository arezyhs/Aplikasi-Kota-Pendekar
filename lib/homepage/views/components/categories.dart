// ignore_for_file: duplicate_import, unused_import, deprecated_member_use

// import 'package:flutter_launcher_name/flutter_launcher_name.dart';
import 'dart:async';
import 'dart:convert';

import 'package:audio_session/audio_session.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/manekin.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/mbangunswarga.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/awaksigap.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/madiuntoday.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/mbangunswarga.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/opendata.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/peceltumpang.dart';
import 'package:pendekar/homepage/menu/layanan_asn.dart';
import 'package:pendekar/homepage/menu/layanankesehatan.dart';
import 'package:pendekar/homepage/menu/layananpengaduan.dart';
import 'package:pendekar/homepage/menu/layananpublik.dart';
import 'package:pendekar/homepage/menu/layananinformasi.dart';
import 'package:pendekar/homepage/menu/lainnya.dart';
import 'package:pendekar/screens/layanan/layanan_screen.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:pendekar/homepage/views/components/dialog_warning.dart';
import 'package:pendekar/homepage/views/components/circle_category.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:url_launcher/url_launcher.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 500);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Combine all categories into a single list
    final combined = [
      {
        "icon": "assets/images/imgicon/mbangun.png",
        "text": "MBANGUN SWARGA",
        "page": const WebMbangunswarga(),
      },
      {
        "icon": "assets/images/imgicon/manekin.png",
        "text": "MANEKIN",
        "page": const WebManekin(),
      },
      {
        "icon": "assets/images/imgicon/pecel.png",
        "text": "Layanan Kesehatan",
        "page": const LayananKesehatan(),
      },
      {
        "icon": "assets/images/imgicon/ekinerja.png",
        "text": "CCTV",
        "appId": "id.olean.cctv_madiun",
        "uriScheme": "cctv://",
      },
      {
        "icon": "assets/images/imgicon/peceltumpang.png",
        "text": "INFORMASI",
        "page": const LayananInformasi(),
      },
    ];

    Future<void> launchPlayStore(String appId) async {
      final String playStoreUrl =
          'https://play.google.com/store/apps/details?id=$appId';
      final Uri playStoreUri = Uri.parse(playStoreUrl);
      await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
    }

    void openApp(String appId, String uriScheme) async {
      final Uri uri = Uri.parse(uriScheme);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchPlayStore(appId);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          combined.length,
          (index) {
            final item = combined[index];
            return GestureDetector(
              onTap: () {
                if (item.containsKey('page')) {
                  final page = item['page'];
                  if (page is DialogWarning) {
                    DialogWarning.show(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => page as Widget),
                    );
                  }
                } else if (item.containsKey('appId')) {
                  openApp(item['appId'] as String, item['uriScheme'] as String);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleCategory(iconPath: item['icon'] as String),
                  const SizedBox(height: 6),
                  Flexible(
                    child: Text(
                      item['text'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.028,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
