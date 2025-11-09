// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int _current = 0;

  final List<String> imageList = [
    "assets/images/banner/webbanner.png",
    "assets/images/banner/bannermadkot.jpeg",
    // "assets/images/banner/webbanner.png"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.03;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          CarouselSlider(
            items: imageList.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: size.width * 0.85,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: const Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                "",
                                style: TextStyle(fontSize: 19),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            // no explicit controller; use internal paging
            options: CarouselOptions(
              height: size.height * 0.15,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              return Container(
                width: 20.0,
                height: 5.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  shape: BoxShape.rectangle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
