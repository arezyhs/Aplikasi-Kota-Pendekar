/// Configuration service untuk mengelola URLs dan environment settings
class AppConfig {
  AppConfig._();

  // Environment types
  static const String _development = 'development';
  static const String _staging = 'staging';
  static const String _production = 'production';

  // Current environment (default production)
  static String _currentEnvironment = _production;

  /// Ambil environment saat ini
  static String get currentEnvironment => _currentEnvironment;

  /// Set environment (untuk testing atau development)
  static void setEnvironment(String environment) {
    _currentEnvironment = environment;
  }

  // Base URLs untuk setiap environment
  static const Map<String, String> _baseUrls = {
    _development: 'https://dev.madiunkota.go.id',
    _staging: 'https://staging.madiunkota.go.id',
    _production: 'https://madiunkota.go.id',
  };

  /// Get base URL based on current environment
  static String get baseUrl =>
      _baseUrls[_currentEnvironment] ?? _baseUrls[_production]!;

  // URLs untuk aplikasi ASN (Aparatur Sipil Negara) - Updated dengan URL yang benar
  static const Map<String, String> _asnApps = {
    // URL AKTIF
    'absenrapat': 'https://erapat.madiunkota.go.id/', // Fixed URL
    'agendasurat': 'https://undangan.madiunkota.go.id/',
    'analisaberita': 'https://analisaberita.madiunkota.go.id/',
    'buktidukungspbe': 'https://buktidukung.madiunkota.go.id/login',
    'carehub': 'https://mobdin.madiunkota.go.id/login',
    'digiform': 'https://digiform.madiunkota.go.id/login',
    'dinsosapp': 'https://dinsosapp.madiunkota.go.id/',
    'emonev': 'https://emonev.madiunkota.go.id/login',
    'esppd': 'https://esppd.madiunkota.go.id/',
    'gedungdiklat': 'https://gedungdiklat.madiunkota.go.id/login',
    'jdih': 'https://jdih.madiunkota.go.id/',
    'lppd': 'https://lppd.madiunkota.go.id/',
    'manekin': 'https://manekin.madiunkota.go.id/',
    'ppkm': 'https://ppkm.madiunkota.go.id/login',
    'proumkm': 'https://proumkm.madiunkota.go.id/login',
    'retribusi': 'https://retribusi.madiunkota.go.id/login',
    'ruangrapat': 'https://ruangrapat.madiunkota.go.id/',
    'satudata': 'https://satudata.madiunkota.go.id/',
    'sdm': 'https://sdm.madiunkota.go.id/',
    'sicakep': 'https://agenda.madiunkota.go.id/',
    'sikd': 'https://sikd.madiunkota.go.id/',
    'silandep': 'https://silandep.madiunkota.go.id/',
    'simandor': 'https://simandor.madiunkota.go.id/',
    'simonev': 'https://simonev.madiunkota.go.id/login',
    'siopa': 'https://siopa.madiunkota.go.id/',
    'sitebas': 'https://sitebas.madiunkota.go.id/',
    'wbs': 'https://wbs.madiunkota.go.id/',

    // URL YANG DI-COMMENT (TIDAK AKTIF) - disimpan untuk referensi
    'beasiswamahasiswa': 'https://beasiswa.madiunkota.go.id/', // Not active
    'ekak': 'https://ekak.madiunkota.go.id/', // Not active
    'esakip': 'https://esakip.madiunkota.go.id/login', // Not active
    'esurat': 'https://esurat.madiunkota.go.id/', // Not active
    'ewaris': 'https://ewaris.madiunkota.go.id/', // Not active
    'exec': 'https://exec.madiunkota.go.id/login', // Not active
    'manpro': 'https://manpro.madiunkota.go.id/login', // Not active
    'puskesos': 'https://puskesos.madiunkota.go.id/login', // Not active
    'simpeg': 'https://simpeg.madiunkota.go.id/', // Not active
    'sipdok': 'https://sipdok.madiunkota.go.id/', // Not active
    'skp': 'https://skp.madiunkota.go.id/login', // Not active
  };

  // URLs untuk aplikasi Warga (Citizen) - Updated dengan URL yang benar
  static const Map<String, String> _wargaApps = {
    // URL AKTIF
    'opendata': 'https://opendata.madiunkota.go.id/',
    'antriankesehatan': 'https://dinkes.madiunkota.go.id/web/',
    'antrianrs': 'https://rsudkotamadiun.my.id/sogaten/',
    'awaksigap': 'https://awaksigap.madiunkota.go.id/',
    'bakul': 'https://bakul.madiunkota.go.id/',
    'bookingprc': 'https://bookingprc.madiunkota.go.id/',
    'esayur': 'https://esayur.madiunkota.go.id/',
    'madiuntoday': 'https://madiuntoday.id/',
    'matawarga': 'https://matawarga.madiunkota.go.id/',
    'mbangunswarga': 'https://mbangunswarga.madiunkota.go.id/login',
    'ppid': 'https://ppid.madiunkota.go.id/',
    'sikepo': 'https://sikepo.madiunkota.go.id/',
    'smartcity': 'https://smartcity.madiunkota.go.id/',

    // URL YANG DI-COMMENT (TIDAK AKTIF) - disimpan untuk referensi
    'edu': 'https://edu.madiunkota.go.id/', // Not active
    'peceltumpang': 'https://peceltumpang.madiunkota.go.id/', // Not active
    'sicaker': 'https://sicaker.madiunkota.go.id/', // Not active
  };

  // RSS Feed URLs
  static const List<String> _rssFeeds = [
    'https://rss.app/feeds/v1.1/rHyalNohjMNACgTx.json',
    'https://rss.app/feeds/v1.1/YEWvQYsh1VcyU0a6.json',
    'https://rss.app/feeds/v1.1/oBYCZ1GV2crnFf21.json',
  ];

  /// Ambil URL untuk aplikasi ASN
  static String getAsnAppUrl(String appKey) {
    final url = _asnApps[appKey];
    if (url == null) {
      throw ArgumentError('ASN app key "$appKey" not found');
    }
    return url;
  }

  /// Ambil URL untuk aplikasi Warga
  static String getWargaAppUrl(String appKey) {
    final url = _wargaApps[appKey];
    if (url == null) {
      throw ArgumentError('Warga app key "$appKey" not found');
    }
    return url;
  }

  /// Ambil RSS feed URLs
  static List<String> get rssFeeds => _rssFeeds;

  /// Cek apakah app key ada di ASN apps
  static bool hasAsnApp(String appKey) {
    return _asnApps.containsKey(appKey);
  }

  /// Cek apakah app key ada di Warga apps
  static bool hasWargaApp(String key) {
    return _wargaApps.containsKey(key);
  }

  /// Ambil semua ASN app keys
  static List<String> get asnAppKeys => _asnApps.keys.toList();

  /// Ambil semua Warga app keys
  static List<String> get wargaAppKeys => _wargaApps.keys.toList();

  // App-specific configurations
  static const int splashDuration = 5000; // milliseconds
  static const int httpTimeout = 30; // seconds
  static const int maxNewsItems = 10;
  static const int newsPreviewItems = 5;

  // RSS Feed URLs (centralized for consistency)
  static const List<String> rssFeedUrls = [
    'https://rss.app/feeds/v1.1/rHyalNohjMNACgTx.json', // @pemkotmadiun_
    'https://rss.app/feeds/v1.1/YEWvQYsh1VcyU0a6.json', // @ppidkotamadiun
    'https://rss.app/feeds/v1.1/oBYCZ1GV2crnFf21.json', // @93fmsuaramadiun
  ];

  // Feature flags
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableOfflineMode = false;
}
