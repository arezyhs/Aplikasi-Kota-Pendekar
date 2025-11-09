import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/homepage/size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6, //60% dari lebar

      decoration: BoxDecoration(
        color: hSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) {
          //searchvalue
        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Cari Layanan",
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(20),
            vertical: getProportionateScreenWidth(9),
          ),
        ),
      ),
    );
  }
}
