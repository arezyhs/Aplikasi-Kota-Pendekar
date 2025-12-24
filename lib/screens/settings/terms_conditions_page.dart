import 'package:flutter/material.dart';
import 'package:pendekar/widgets/policy_page_widget.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PolicyPageWidget(
      title: 'Syarat & Ketentuan',
      heading: 'Syarat dan Ketentuan Penggunaan',
      subtitle: 'Aplikasi Kota Pendekar',
      sections: [
        PolicySection(
          title: 'Penerimaan Syarat',
          content:
              'Dengan mengunduh, menginstal, dan menggunakan Aplikasi Kota Pendekar, Anda setuju untuk terikat oleh syarat dan ketentuan berikut. Jika Anda tidak setuju, mohon untuk tidak menggunakan aplikasi ini.',
        ),
        PolicySection(
          title: 'Penggunaan Aplikasi',
          content:
              '• Aplikasi ini disediakan untuk memudahkan akses masyarakat terhadap layanan publik Kota Madiun\n'
              '• Pengguna harus berusia minimal 17 tahun atau memiliki izin orang tua/wali\n'
              '• Dilarang menggunakan aplikasi untuk tujuan ilegal atau melanggar hukum\n'
              '• Pengguna bertanggung jawab atas keakuratan informasi yang diberikan',
        ),
        PolicySection(
          title: 'Akun Pengguna',
          content:
              '• Anda bertanggung jawab untuk menjaga kerahasiaan informasi akun Anda\n'
              '• Setiap aktivitas yang dilakukan melalui akun Anda adalah tanggung jawab Anda\n'
              '• Segera laporkan jika terjadi penggunaan tidak sah atas akun Anda\n'
              '• Pemerintah Kota Madiun berhak menonaktifkan akun yang melanggar ketentuan',
        ),
        PolicySection(
          title: 'Layanan yang Tersedia',
          content:
              'Aplikasi menyediakan berbagai layanan publik termasuk namun tidak terbatas pada:\n'
              '• Informasi dan berita daerah\n'
              '• Pengaduan masyarakat\n'
              '• Layanan administrasi online\n'
              '• Layanan kesehatan dan pendidikan\n'
              '• Layanan ASN',
        ),
        PolicySection(
          title: 'Pembatasan Tanggung Jawab',
          content: 'Pemerintah Kota Madiun tidak bertanggung jawab atas:\n'
              '• Gangguan teknis atau kegagalan sistem\n'
              '• Kesalahan atau kelalaian dalam konten\n'
              '• Kerugian yang timbul dari penggunaan aplikasi\n'
              '• Ketersediaan layanan yang berkelanjutan',
        ),
        PolicySection(
          title: 'Hak Kekayaan Intelektual',
          content:
              'Semua konten, fitur, dan fungsi aplikasi ini adalah milik Pemerintah Kota Madiun dan dilindungi oleh hukum kekayaan intelektual yang berlaku.',
        ),
        PolicySection(
          title: 'Perubahan Syarat',
          content:
              'Kami berhak mengubah syarat dan ketentuan ini sewaktu-waktu. Perubahan akan berlaku setelah dipublikasikan dalam aplikasi. Penggunaan berkelanjutan setelah perubahan berarti Anda menyetujui perubahan tersebut.',
        ),
        PolicySection(
          title: 'Hukum yang Berlaku',
          content:
              'Syarat dan ketentuan ini tunduk pada hukum Republik Indonesia. Setiap perselisihan akan diselesaikan melalui pengadilan yang berwenang di Indonesia.',
        ),
        PolicySection(
          title: 'Kontak',
          content: 'Untuk pertanyaan mengenai Syarat & Ketentuan, hubungi:\n\n'
              'Dinas Komunikasi dan Informatika Kota Madiun\n'
              'Jln. Perintis Kemerdekaan, No.32, Madiun\n'
              'Email: kominfo@madiunkota.go.id\n'
              'Telepon: (0351) 467327',
        ),
      ],
    );
  }
}
