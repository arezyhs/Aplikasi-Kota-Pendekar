import 'package:flutter/material.dart';
import 'package:pendekar/widgets/policy_page_widget.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PolicyPageWidget(
      title: 'Kebijakan Privasi',
      heading: 'Kebijakan Privasi Aplikasi Kota Pendekar',
      subtitle: 'Terakhir diperbarui: Desember 2025',
      sections: [
        PolicySection(
          title: 'Pendahuluan',
          content:
              'Aplikasi Kota Pendekar adalah aplikasi resmi Pemerintah Kota Madiun yang dirancang untuk memberikan kemudahan akses layanan publik kepada masyarakat. Kami berkomitmen untuk melindungi privasi dan keamanan data pengguna.',
        ),
        PolicySection(
          title: 'Informasi yang Kami Kumpulkan',
          content: '• Data identitas (nama, NIK, email, nomor telepon)\n'
              '• Data lokasi untuk layanan berbasis lokasi\n'
              '• Data penggunaan aplikasi\n'
              '• Data perangkat dan informasi teknis',
        ),
        PolicySection(
          title: 'Penggunaan Informasi',
          content: 'Informasi yang dikumpulkan digunakan untuk:\n'
              '• Menyediakan dan meningkatkan layanan\n'
              '• Memproses permohonan dan pengaduan\n'
              '• Mengirimkan notifikasi penting\n'
              '• Analisis dan pengembangan aplikasi',
        ),
        PolicySection(
          title: 'Keamanan Data',
          content:
              'Kami menerapkan langkah-langkah keamanan yang sesuai untuk melindungi data Anda dari akses, penggunaan, atau pengungkapan yang tidak sah. Data Anda disimpan di server yang aman dan hanya dapat diakses oleh pihak yang berwenang.',
        ),
        PolicySection(
          title: 'Berbagi Informasi',
          content:
              'Kami tidak akan membagikan informasi pribadi Anda kepada pihak ketiga tanpa persetujuan Anda, kecuali diwajibkan oleh hukum atau untuk keperluan pelayanan publik yang sah.',
        ),
        PolicySection(
          title: 'Hak Pengguna',
          content: 'Anda memiliki hak untuk:\n'
              '• Mengakses dan memperbarui data pribadi Anda\n'
              '• Meminta penghapusan data\n'
              '• Menarik persetujuan penggunaan data\n'
              '• Mengajukan keluhan terkait privasi',
        ),
        PolicySection(
          title: 'Hubungi Kami',
          content:
              'Jika Anda memiliki pertanyaan tentang Kebijakan Privasi ini, silakan hubungi:\n\n'
              'Dinas Komunikasi dan Informatika Kota Madiun\n'
              'Jln. Perintis Kemerdekaan, No.32, Madiun\n'
              'Email: kominfo@madiunkota.go.id\n'
              'Telepon: (0351) 467327',
        ),
      ],
    );
  }
}
