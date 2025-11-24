# Aplikasi Kota Pendekar

Ringkasan singkat aplikasi mobile Flutter Smart Governance "Aplikasi Pendekar Kota Madiun".

**Project**: `Aplikasi-Kota-Pendekar`

**Tujuan**: Menyajikan layanan pemerintahan kota, daftar aplikasi, feed berita, dan fitur cepat (WhatsApp CTA, Radio). UI mobile-first untuk Android/iOS/web.

## Struktur Repository

```
Aplikasi-Pendekar/
├── analysis_options.yaml      # Konfigurasi Dart analyzer
├── pubspec.yaml               # Dependencies dan metadata project
├── pubspec.lock              # Lock file untuk reproducible builds
├── README.md                 # Dokumentasi project
├── assets/                   # Asset aplikasi
│   ├── fonts/               # Font kustom (Muli)
│   ├── icons/               # Icon aplikasi
│   ├── images/              # Gambar dan ilustrasi
│   │   ├── banner/          # Banner home screen
│   │   ├── imgicon/         # Icon menu layanan
│   │   └── jdih/            # Asset JDIH
│   └── imgOpendata/         # Asset Open Data
├── lib/                     # Source code Dart/Flutter
│   ├── main.dart           # Entry point aplikasi
│   ├── routes.dart         # Definisi routing
│   ├── api/                # API services
│   │   ├── apiedu.dart     # API Education
│   │   ├── apimarketplace.dart  # API Marketplace
│   │   └── apiproumkm.dart # API Pro UMKM
│   ├── constants/          # Konstanta aplikasi
│   │   ├── constant.dart   # Konstanta umum
│   │   ├── navigation.dart # Navigation constants
│   │   └── permission.dart # Permission constants
│   ├── daftarAplikasi/     # Daftar aplikasi
│   │   ├── aplikasi ASN/   # Aplikasi untuk ASN
│   │   └── aplikasi warga/ # Aplikasi untuk warga
│   ├── homepage/           # Komponen homepage
│   │   ├── size_config.dart
│   │   ├── menu/           # Menu components
│   │   └── views/          # UI components
│   ├── screens/            # Screen widgets
│   │   ├── berita/         # Screen berita
│   │   ├── home/           # Home screen
│   │   └── layanan/        # Screen layanan
│   └── utils/              # Utilities
│       ├── feature_registry.dart
│       ├── web_container_page.dart
│       ├── helpers/        # Helper functions
│       └── services/       # Services layer
├── android/                # Android platform code
├── ios/                   # iOS platform code
├── web/                   # Web platform code
├── windows/               # Windows platform code
├── linux/                # Linux platform code
├── macos/                # macOS platform code
└── test/                  # Unit tests
    └── widget_test.dart   # Widget testing
```

**Direktori penting**
- **`lib/`**: kode sumber utama Flutter.
- **`lib/screens/home/home_screen.dart`**: layar Home (berisi menu utama, berita ringkas, banner).
- **`lib/homepage/views/components/`**: komponen-komponen kecil (banner, carousel, announcement card, dll.).

**Persyaratan**
- Flutter SDK (disarankan versi stabil terbaru). Pastikan `flutter doctor` bersih.

**Install & Run (Windows / PowerShell)**
1. Install dependencies:

```powershell
flutter pub get
```

2. Jalankan aplikasi pada device/emulator:

```powershell
flutter run
```

3. Jalankan analyzer statis:

```powershell
flutter analyze
```

4. Untuk membersihkan build (jika perlu):

```powershell
flutter clean
```

**Perubahan penting**
- News feed on Home (`NewsPreview`) menampilkan 3 berita terbaru sebagai list (`ListTile`)
- Layanan utama (`_LayananUtama` in `home_screen.dart`) menampilkan tile bergaya card/InkWell, konsisten dengan `layanan_screen.dart`.
- Beberapa pages/webviews telah dimodifikasi untuk menggunakan AppBar actions (reload + open in external browser) dan untuk menghindari penggunaan `BuildContext` setelah `await` dengan cara menangkap `ScaffoldMessenger.of(context)` lebih awal atau menggunakan global navigator key pattern.

**Lint & style**
- Project masih memiliki sejumlah lints gaya (prefer_const_*, file_names) yang dapat diperbaiki bertahap. Saya merekomendasikan menjalankan `flutter analyze` lalu memperbaiki perubahan bergelombang (bulk small edits) untuk menghindari banyak edit-analyzing loops.