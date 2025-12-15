import 'package:flutter/material.dart';
import 'package:pendekar/utils/services/local_storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _cacheSize = 'Menghitung...';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final notifications = LocalStorageService.getBool('notifications') ?? true;
    final darkMode = LocalStorageService.getBool('dark_mode') ?? false;

    setState(() {
      _notificationsEnabled = notifications;
      _darkModeEnabled = darkMode;
      _cacheSize = '0 MB'; // Placeholder
    });
  }

  Future<void> _clearCache() async {
    // Show confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Cache'),
        content: const Text('Yakin ingin menghapus semua cache aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // Clear cache logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache berhasil dihapus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        children: [
          // Aplikasi Section
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'APLIKASI',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Notifikasi'),
            subtitle: const Text('Terima notifikasi dari aplikasi'),
            value: _notificationsEnabled,
            onChanged: (value) async {
              setState(() => _notificationsEnabled = value);
              await LocalStorageService.setBool('notifications', value);
            },
          ),
          SwitchListTile(
            title: const Text('Mode Gelap'),
            subtitle: const Text('Ubah tema menjadi mode gelap'),
            value: _darkModeEnabled,
            onChanged: (value) async {
              setState(() => _darkModeEnabled = value);
              await LocalStorageService.setBool('dark_mode', value);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Restart aplikasi untuk menerapkan tema baru'),
                ),
              );
            },
          ),

          const Divider(),

          // Penyimpanan Section
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'PENYIMPANAN',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            title: const Text('Cache Aplikasi'),
            subtitle: Text(_cacheSize),
            trailing: TextButton(
              onPressed: _clearCache,
              child: const Text('Hapus'),
            ),
          ),

          const Divider(),

          // Tentang Section
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'TENTANG',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            title: const Text('Versi Aplikasi'),
            subtitle: const Text('1.2.6+6'),
            trailing: const Icon(Icons.info_outline),
          ),
          ListTile(
            title: const Text('Tentang Aplikasi'),
            subtitle: const Text('Informasi lengkap tentang Kota Pendekar'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Kota Pendekar',
                applicationVersion: '1.2.6+6',
                applicationLegalese: '© 2024 Pemerintah Kota Madiun',
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Aplikasi resmi Pemerintah Kota Madiun untuk melayani masyarakat dengan lebih baik.',
                  ),
                ],
              );
            },
          ),
          ListTile(
            title: const Text('Kebijakan Privasi'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to privacy policy
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kebijakan Privasi')),
              );
            },
          ),
          ListTile(
            title: const Text('Syarat & Ketentuan'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to terms
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Syarat & Ketentuan')),
              );
            },
          ),
        ],
      ),
    );
  }
}
