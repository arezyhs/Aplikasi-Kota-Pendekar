import 'package:flutter/material.dart';
// size_config not needed here; use fixed padding for consistent layout

class HomeDescription extends StatelessWidget {
  const HomeDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          child: Text(
            "Ringkasan berita terbaru dari portal kota.",
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
