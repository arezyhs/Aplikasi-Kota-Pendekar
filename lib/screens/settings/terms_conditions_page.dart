import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Syarat & Ketentuan',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Syarat dan Ketentuan Penggunaan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aplikasi Kota Pendekar',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Penerimaan Syarat',
              'Dengan mengunduh, menginstal, dan menggunakan Aplikasi Kota Pendekar, Anda setuju untuk terikat oleh syarat dan ketentuan berikut. Jika Anda tidak setuju, mohon untuk tidak menggunakan aplikasi ini.',
            ),
            _buildSection(
              'Penggunaan Aplikasi',
              '• Aplikasi ini disediakan untuk memudahkan akses masyarakat terhadap layanan publik Kota Madiun\n'
                  '• Pengguna harus berusia minimal 17 tahun atau memiliki izin orang tua/wali\n'
                  '• Dilarang menggunakan aplikasi untuk tujuan ilegal atau melanggar hukum\n'
                  '• Pengguna bertanggung jawab atas keakuratan informasi yang diberikan',
            ),
            _buildSection(
              'Akun Pengguna',
              '• Anda bertanggung jawab untuk menjaga kerahasiaan informasi akun Anda\n'
                  '• Setiap aktivitas yang dilakukan melalui akun Anda adalah tanggung jawab Anda\n'
                  '• Segera laporkan jika terjadi penggunaan tidak sah atas akun Anda\n'
                  '• Pemerintah Kota Madiun berhak menonaktifkan akun yang melanggar ketentuan',
            ),
            _buildSection(
              'Layanan yang Tersedia',
              'Aplikasi menyediakan berbagai layanan publik termasuk namun tidak terbatas pada:\n'
                  '• Informasi dan berita daerah\n'
                  '• Pengaduan masyarakat\n'
                  '• Layanan administrasi online\n'
                  '• Layanan kesehatan dan pendidikan\n'
                  '• Layanan ASN',
            ),
            _buildSection(
              'Pembatasan Tanggung Jawab',
              'Pemerintah Kota Madiun tidak bertanggung jawab atas:\n'
                  '• Gangguan teknis atau kegagalan sistem\n'
                  '• Kesalahan atau kelalaian dalam konten\n'
                  '• Kerugian yang timbul dari penggunaan aplikasi\n'
                  '• Ketersediaan layanan yang berkelanjutan',
            ),
            _buildSection(
              'Hak Kekayaan Intelektual',
              'Semua konten, fitur, dan fungsi aplikasi ini adalah milik Pemerintah Kota Madiun dan dilindungi oleh hukum kekayaan intelektual yang berlaku.',
            ),
            _buildSection(
              'Perubahan Syarat',
              'Kami berhak mengubah syarat dan ketentuan ini sewaktu-waktu. Perubahan akan berlaku setelah dipublikasikan dalam aplikasi. Penggunaan berkelanjutan setelah perubahan berarti Anda menyetujui perubahan tersebut.',
            ),
            _buildSection(
              'Hukum yang Berlaku',
              'Syarat dan ketentuan ini tunduk pada hukum Republik Indonesia. Setiap perselisihan akan diselesaikan melalui pengadilan yang berwenang di Indonesia.',
            ),
            _buildSection(
              'Kontak',
              'Untuk pertanyaan mengenai Syarat & Ketentuan, hubungi:\n\n'
                  'Dinas Komunikasi dan Informatika\n'
                  'Pemerintah Kota Madiun\n'
                  'Email: diskominfo@madiunkota.go.id\n'
                  'Telepon: (0351) 464197',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
