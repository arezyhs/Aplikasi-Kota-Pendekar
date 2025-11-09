import 'package:flutter/material.dart';
import 'package:pendekar/homepage/size_config.dart';

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
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            // vertical: getProportionateScreenHeight(5),
          ),
          width: double.infinity,
          child: Text(
            "Berita Terkini :",
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
