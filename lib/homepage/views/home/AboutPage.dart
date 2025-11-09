import 'package:flutter/material.dart';
import 'package:pendekar/homepage/size_config.dart';

class HomeDescription2 extends StatelessWidget {
  const HomeDescription2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(15),
      ),
      width: double.infinity,
      child: Text.rich(TextSpan(
          text: "Selamat datang di Aplikasi Pendekar Kota Madiun \n",
          style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 18,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(
                text: "Nikmati kemudahan dengan Aplikasi Pendekar Kota Madiun",
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic))
          ])),
    );
  }
}
