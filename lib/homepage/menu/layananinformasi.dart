// ignore_for_file: prefer_const_constructors

// Refactored: Menggunakan CategoryMenuScreen generic
import 'package:flutter/material.dart';
import 'package:pendekar/widgets/category_menu_screen.dart';

class LayananInformasi extends StatelessWidget {
  const LayananInformasi({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryMenuScreen(
      categoryId: 'informasi',
      title: 'Layanan Informasi',
    );
  }
}
