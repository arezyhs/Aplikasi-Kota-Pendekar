import 'package:flutter/material.dart';
import 'package:pendekar/homepage/size_config.dart';

class CircleCategory extends StatelessWidget {
  const CircleCategory({Key? key, required this.iconPath}) : super(key: key);

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    final double size = getProportionateScreenWidth(60);
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      child: Center(
        child: Image.asset(
          iconPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
