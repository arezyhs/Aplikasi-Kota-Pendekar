// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pendekar/homepage/views/components/categories.dart';
import 'package:pendekar/homepage/views/components/home_banner.dart';
import 'package:pendekar/homepage/views/components/home_caraousel.dart';
import 'package:pendekar/homepage/views/components/home_description.dart';
import 'package:pendekar/homepage/views/components/home_wa.dart';
import 'package:pendekar/homepage/views/components/ppidbanner.dart';
import 'package:pendekar/homepage/views/components/radio93fm.dart';
import 'package:permission_handler/permission_handler.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
    var cameraStatus = await Permission.camera.request();
    if (!cameraStatus.isGranted) {
      print('Permission to access camera is denied');
    }

    var mediaLibrary = await Permission.mediaLibrary.request();
    if (!mediaLibrary.isGranted) {
      print('Permission to access storage is denied');
    }

    var storageStatus = await Permission.storage.request();
    if (!storageStatus.isGranted) {
      print('Permission to access storage is denied');
    }

    var photosStatus = await Permission.photos.request();
    if (!photosStatus.isGranted) {
      print('Permission to access photos is denied');
    }

    var mediaLocationStatus = await Permission.accessMediaLocation.request();
    if (!mediaLocationStatus.isGranted) {
      print('Permission to access media location is denied');
    }

    var notificationStatus = await Permission.notification.request();
    if (!notificationStatus.isGranted) {
      print('Permission to access notification is denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const HomeBanner(),
              SizedBox(
                height: size.height * 0.02,
              ),
              const whatsapp(),
              SizedBox(
                height: size.height * 0.02,
              ),
              Categories(),
              SizedBox(
                height: size.height * 0.01,
              ),
              const ppidBanner(),
              SizedBox(
                height: size.height * 0.01,
              ),
              HomePlayer(),
              SizedBox(
                height: size.height * 0.01,
              ),
              const HomeDescription(),
              HomeCaraousel(),
            ],
          ),
        ),
      ),
    );
  }
}
