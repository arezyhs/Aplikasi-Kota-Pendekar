import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kebijakan Privasi',
          style: TextStyle(
            fontWeight: AppFontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kebijakan Privasi Aplikasi Kota Pendekar',
              style: TextStyle(
                fontSize: AppTextSize.display,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Terakhir diperbarui: Desember 2025',
              style: TextStyle(
                fontSize: AppTextSize.body,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Pendahuluan',
              'Aplikasi Kota Pendekar adalah aplikasi resmi Pemerintah Kota Madiun yang dirancang untuk memberikan kemudahan akses layanan publik kepada masyarakat. Kami berkomitmen untuk melindungi privasi dan keamanan data pengguna.',
            ),
            _buildSection(
              'Informasi yang Kami Kumpulkan',
              '• Data identitas (nama, NIK, email, nomor telepon)\n'
                  '• Data lokasi untuk layanan berbasis lokasi\n'
                  '• Data penggunaan aplikasi\n'
                  '• Data perangkat dan informasi teknis',
            ),
            _buildSection(
              'Penggunaan Informasi',
              'Informasi yang dikumpulkan digunakan untuk:\n'
                  '• Menyediakan dan meningkatkan layanan\n'
                  '• Memproses permohonan dan pengaduan\n'
                  '• Mengirimkan notifikasi penting\n'
                  '• Analisis dan pengembangan aplikasi',
            ),
            _buildSection(
              'Keamanan Data',
              'Kami menerapkan langkah-langkah keamanan yang sesuai untuk melindungi data Anda dari akses, penggunaan, atau pengungkapan yang tidak sah. Data Anda disimpan di server yang aman dan hanya dapat diakses oleh pihak yang berwenang.',
            ),
            _buildSection(
              'Berbagi Informasi',
              'Kami tidak akan membagikan informasi pribadi Anda kepada pihak ketiga tanpa persetujuan Anda, kecuali diwajibkan oleh hukum atau untuk keperluan pelayanan publik yang sah.',
            ),
            _buildSection(
              'Hak Pengguna',
              'Anda memiliki hak untuk:\n'
                  '• Mengakses dan memperbarui data pribadi Anda\n'
                  '• Meminta penghapusan data\n'
                  '• Menarik persetujuan penggunaan data\n'
                  '• Mengajukan keluhan terkait privasi',
            ),
            _buildSection(
              'Hubungi Kami',
              'Jika Anda memiliki pertanyaan tentang Kebijakan Privasi ini, silakan hubungi:\n\n'
                  'Dinas Komunikasi dan Informatika Kota Madiun\n'
                  'Jln. Perintis Kemerdekaan, No.32, Madiun\n'
                  'Email: kominfo@madiunkota.go.id\n'
                  'Telepon: (0351) 467327',
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
              fontSize: AppTextSize.subtitle,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: AppTextSize.subtitle,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
