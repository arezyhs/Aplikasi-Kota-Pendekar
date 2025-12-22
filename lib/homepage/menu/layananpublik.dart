// ignore_for_file: prefer_const_constructors

// Refactored: Menggunakan CategoryMenuScreen generic
import 'package:flutter/material.dart';
import 'package:pendekar/widgets/category_menu_screen.dart';

class LayananPublik extends StatelessWidget {
  const LayananPublik({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryMenuScreen(
      categoryId: 'publik',
      title: 'Layanan Publik',
    );
  }
}
