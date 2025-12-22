import 'package:flutter/material.dart';

// Model untuk kategori layanan
class LayananCategory {
  final String id;
  final String title;
  final IconData icon;
  final List<LayananApp> apps;

  const LayananCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.apps,
  });
}

// Model untuk aplikasi layanan
class LayananApp {
  final String icon;
  final String text;
  final String? appId;
  final String? uriScheme;
  final dynamic page;

  const LayananApp({
    required this.icon,
    required this.text,
    this.appId,
    this.uriScheme,
    this.page,
  });

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'text': text,
      if (appId != null) 'appId': appId,
      if (uriScheme != null) 'uriScheme': uriScheme,
      if (page != null) 'page': page,
    };
  }
}
