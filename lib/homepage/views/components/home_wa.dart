import 'package:flutter/material.dart';
import 'package:pendekar/homepage/views/home/announcementcard.dart';

class whatsapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnnouncementCard(
        announcementText: 'WHATSAPP AWAK SIGAP 112',
        onPressed: () {
          // Aksi yang akan dilakukan saat tombol ditekan
          print('Tombol Klik Disini ditekan!');
        },
      ),
    );
  }
}
