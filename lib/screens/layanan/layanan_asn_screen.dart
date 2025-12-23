// ignore_for_file: prefer_const_constructors

// Refactored: Menggunakan CategoryMenuScreen generic
// Mengurangi duplicasi dan menggunakan centralized data
import 'package:flutter/material.dart';
import 'package:pendekar/widgets/category_menu_screen.dart';

class LayananAsnScreen extends StatelessWidget {
  const LayananAsnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryMenuScreen(
      categoryId: 'asn',
      title: 'Layanan ASN',
    );
  }
}
