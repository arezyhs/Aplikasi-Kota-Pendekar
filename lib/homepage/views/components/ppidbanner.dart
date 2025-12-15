// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/ppid.dart';

class PpidBanner extends StatelessWidget {
  const PpidBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WebPpid()),
          );
        },
        child: Card(
          elevation: 2,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/ppidbanner.png'), // Ganti dengan path gambar pattern Anda
                fit: BoxFit.contain,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: size.height * 0.1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width * 0.01,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
