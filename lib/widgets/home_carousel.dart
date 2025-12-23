// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last, deprecated_member_use, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unused_field

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    if (items.isEmpty) return const SizedBox.shrink();

    return CarouselSlider(
      options: CarouselOptions(
        scrollPhysics: const BouncingScrollPhysics(),
        pageSnapping: true,
        autoPlayInterval: const Duration(seconds: 5),
        // disable autoPlay to avoid timer callbacks after widget disposal
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 1,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.elasticOut,
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
      items: items,
    );
  }
}
