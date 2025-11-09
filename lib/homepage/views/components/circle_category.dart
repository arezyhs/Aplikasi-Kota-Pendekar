import 'package:flutter/material.dart';

class CircleCategory extends StatelessWidget {
  final String iconPath;

  const CircleCategory({
    Key? key,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: Center(
        child: Image.asset(
          iconPath,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
