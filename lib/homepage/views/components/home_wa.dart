import 'package:flutter/material.dart';
import 'package:pendekar/homepage/views/home/announcementcard.dart';

class Whatsapp extends StatelessWidget {
  const Whatsapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnnouncementCard(
        announcementText: 'WHATSAPP AWAK SIGAP 112',
        onPressed: () {
          debugPrint('Tombol Klik Disini ditekan!');
        },
      ),
    );
  }
}
