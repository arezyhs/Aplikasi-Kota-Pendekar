import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pendekar/utils/services/local_storage_service.dart';
import 'package:pendekar/utils/services/logger_service.dart';
import 'package:pendekar/utils/accessibility_provider.dart';
import 'package:pendekar/utils/theme_provider.dart';
import 'package:pendekar/screens/settings/privacy_policy_page.dart';
import 'package:pendekar/screens/settings/terms_conditions_page.dart';
import 'package:pendekar/constants/constant.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _largeTextEnabled = false;
  bool _highContrastEnabled = false;
  bool _reducedAnimationsEnabled = false;
  String _cacheSize = 'Menghitung...';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final notifications = LocalStorageService.getBool('notifications') ?? true;
    final largeText = LocalStorageService.getBool('large_text') ?? false;
    final highContrast = LocalStorageService.getBool('high_contrast') ?? false;
    final reducedAnimations =
        LocalStorageService.getBool('reduced_animations') ?? false;

    setState(() {
      _notificationsEnabled = notifications;
      _darkModeEnabled = themeNotifier.isDarkMode;
      _largeTextEnabled = largeText;
      _highContrastEnabled = highContrast;
      _reducedAnimationsEnabled = reducedAnimations;
      _cacheSize = '0 MB'; // Placeholder
    });
  }

  Future<void> _clearCache() async {
    final messenger = ScaffoldMessenger.of(context);
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
      try {
        // Clear WebView cache
        await InAppWebViewController.clearAllCache();

        // Clear cookies
        CookieManager cookieManager = CookieManager.instance();
        await cookieManager.deleteAllCookies();

        Logger.info('Cache cleared successfully');

        messenger.showSnackBar(
          const SnackBar(
            content: Text('Cache dan cookies berhasil dihapus'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        Logger.error('Error clearing cache', error: e);
        messenger.showSnackBar(
          SnackBar(
            content: Text('Gagal menghapus cache: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            fontWeight: AppFontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Aplikasi Section
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'APLIKASI',
              style: TextStyle(
                fontSize: AppTextSize.body,
                fontWeight: AppFontWeight.bold,
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
              await themeNotifier.toggleTheme(value);
            },
          ),

          const Divider(),

          // Aksesibilitas Section
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'AKSESIBILITAS',
              style: TextStyle(
                fontSize: AppTextSize.body,
                fontWeight: AppFontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Teks Besar'),
            subtitle: const Text('Perbesar ukuran teks di seluruh aplikasi'),
            value: _largeTextEnabled,
            onChanged: (value) async {
              setState(() => _largeTextEnabled = value);
              await accessibilityNotifier.updateLargeText(value);
            },
          ),
          SwitchListTile(
            title: const Text('Kontras Tinggi'),
            subtitle:
                const Text('Tingkatkan kontras warna untuk kemudahan membaca'),
            value: _highContrastEnabled,
            onChanged: (value) async {
              setState(() => _highContrastEnabled = value);
              await accessibilityNotifier.updateHighContrast(value);
            },
          ),
          SwitchListTile(
            title: const Text('Kurangi Animasi'),
            subtitle:
                const Text('Kurangi efek animasi untuk performa lebih baik'),
            value: _reducedAnimationsEnabled,
            onChanged: (value) async {
              setState(() => _reducedAnimationsEnabled = value);
              await accessibilityNotifier.updateReducedAnimations(value);
            },
          ),

          const Divider(),

          // Penyimpanan Section
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'PENYIMPANAN',
              style: TextStyle(
                fontSize: AppTextSize.body,
                fontWeight: AppFontWeight.bold,
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
                fontSize: AppTextSize.body,
                fontWeight: AppFontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const ListTile(
            title: Text('Versi Aplikasi'),
            subtitle: Text('1.2.6+6'),
            trailing: Icon(Icons.info_outline),
          ),
          ListTile(
            title: const Text('Tentang Aplikasi'),
            subtitle: const Text('Informasi lengkap tentang Aplikasi Pendekar'),
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
                  const SizedBox(height: 16),
                  const Text(
                    'Dinas Komunikasi dan Informatika Kota Madiun\n'
                    'Jln. Perintis Kemerdekaan, No.32, Madiun\n'
                    'Telepon: (0351) 467327\n'
                    'Email: kominfo@madiunkota.go.id',
                    style: TextStyle(fontSize: AppTextSize.body),
                  ),
                ],
              );
            },
          ),
          ListTile(
            title: const Text('Kebijakan Privasi'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Syarat & Ketentuan'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsConditionsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
