import 'package:flutter/material.dart';
import 'package:pendekar/utils/services/app_config.dart';
import 'package:pendekar/utils/web_container_page.dart';

/// Model untuk aplikasi
class AppItem {
  final String key;
  final String name;
  final String description;
  final IconData icon;
  final Color? color;
  final bool isAsnApp;

  const AppItem({
    required this.key,
    required this.name,
    required this.description,
    required this.icon,
    this.color,
    required this.isAsnApp,
  });
}

/// Registry untuk mengelola semua aplikasi yang tersedia
class FeatureRegistry {
  FeatureRegistry._();

  /// Daftar aplikasi ASN
  static const List<AppItem> _asnApps = [
    AppItem(
      key: 'absenrapat',
      name: 'Absen Rapat',
      description: 'Sistem absensi rapat online',
      icon: Icons.event_available,
      isAsnApp: true,
    ),
    AppItem(
      key: 'simpeg',
      name: 'SIMPEG',
      description: 'Sistem Informasi Pegawai',
      icon: Icons.people,
      color: Colors.blue,
      isAsnApp: true,
    ),
    AppItem(
      key: 'esurat',
      name: 'E-Surat',
      description: 'Sistem surat elektronik',
      icon: Icons.mail,
      color: Colors.green,
      isAsnApp: true,
    ),
    AppItem(
      key: 'sikd',
      name: 'SIKD',
      description: 'Sistem Informasi Keuangan Daerah',
      icon: Icons.account_balance,
      color: Colors.orange,
      isAsnApp: true,
    ),
    AppItem(
      key: 'jdih',
      name: 'JDIH',
      description: 'Jaringan Dokumentasi Informasi Hukum',
      icon: Icons.gavel,
      color: Colors.red,
      isAsnApp: true,
    ),
    // Add more ASN apps...
  ];

  /// Daftar aplikasi Warga
  static const List<AppItem> _wargaApps = [
    AppItem(
      key: 'smartcity',
      name: 'Smart City',
      description: 'Portal Smart City Madiun',
      icon: Icons.location_city,
      color: Colors.blue,
      isAsnApp: false,
    ),
    AppItem(
      key: 'ppid',
      name: 'PPID',
      description: 'Pejabat Pengelola Informasi Dokumentasi',
      icon: Icons.info,
      color: Colors.green,
      isAsnApp: false,
    ),
    AppItem(
      key: 'antriankesehatan',
      name: 'Antrian Puskesmas',
      description: 'Sistem antrian Puskesmas online',
      icon: Icons.local_hospital,
      color: Colors.red,
      isAsnApp: false,
    ),
    AppItem(
      key: 'esayur',
      name: 'E-Sayur',
      description: 'Platform jual beli sayuran online',
      icon: Icons.store,
      color: Colors.green,
      isAsnApp: false,
    ),
    // Add more Warga apps...
  ];

  /// Ambil semua aplikasi ASN
  static List<AppItem> get asnApps => _asnApps;

  /// Ambil semua aplikasi Warga
  static List<AppItem> get wargaApps => _wargaApps;

  /// Ambil semua aplikasi
  static List<AppItem> get allApps => [..._asnApps, ..._wargaApps];

  /// Cari aplikasi berdasarkan query
  static List<AppItem> searchApps(String query, {bool? isAsnApp}) {
    final apps = isAsnApp == null
        ? allApps
        : isAsnApp
            ? _asnApps
            : _wargaApps;

    if (query.isEmpty) return apps;

    final lowercaseQuery = query.toLowerCase();
    return apps
        .where((app) =>
            app.name.toLowerCase().contains(lowercaseQuery) ||
            app.description.toLowerCase().contains(lowercaseQuery))
        .toList();
  }

  /// Ambil aplikasi berdasarkan key
  static AppItem? getAppByKey(String key) {
    try {
      return allApps.firstWhere((app) => app.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Navigasi ke aplikasi
  static void navigateToApp(BuildContext context, AppItem app) {
    try {
      final url = app.isAsnApp
          ? AppConfig.getAsnAppUrl(app.key)
          : AppConfig.getWargaAppUrl(app.key);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BaseWebViewPage(
            url: url,
            title: app.name,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Aplikasi ${app.name} tidak tersedia'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Cek apakah aplikasi tersedia
  static bool isAppAvailable(String key) {
    return getAppByKey(key) != null;
  }

  /// Ambil jumlah aplikasi berdasarkan kategori
  static int getAppCount({bool? isAsnApp}) {
    if (isAsnApp == null) return allApps.length;
    return isAsnApp ? _asnApps.length : _wargaApps.length;
  }
}
