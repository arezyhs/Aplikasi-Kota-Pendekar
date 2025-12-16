# Aplikasi Pendekar Kota Madiun

Aplikasi mobile smart governance untuk layanan pemerintahan Kota Madiun berbasis Flutter.

## Overview

**Pendekar** (Peceland) adalah aplikasi mobile yang menyediakan akses terintegrasi ke berbagai layanan pemerintahan Kota Madiun. Aplikasi ini menggabungkan portal layanan online, feed berita real-time, radio streaming, dan dukungan pelanggan dalam satu platform yang mudah digunakan.

## Fitur

- **Beranda** - Banner informasi, quick actions, dan grid menu 50+ layanan pemerintahan
- **Feed Berita** - Agregasi berita dari Instagram (@pemkotmadiun_, @ppidkotamadiun, @93fmsuaramadiun) dengan pagination
- **Radio Streaming** - Suara Madiun 93FM dengan visualisasi audio
- **Layanan** - Akses ke aplikasi warga (JDIH, Open Data, Pengaduan), ASN (E-Office, Absen Rapat), Edukasi, dan UMKM
- **Pengaturan** - Privacy policy, terms & conditions, informasi aplikasi

## Teknologi

- Flutter 3.0.5+
- Android (minimum API 21)
- WebView integration
- Audio streaming
- RSS feed aggregation

## Instalasi

### Persyaratan
- Flutter SDK ≥ 3.0.5
- Android Studio / VS Code dengan Flutter extension
- Android SDK (minimum API level 21)

### Setup

1. Clone repository
```bash
git clone https://github.com/arezyhs/Aplikasi-Kota-Pendekar.git
cd Aplikasi-Kota-Pendekar
```

2. Install dependencies
```bash
flutter pub get
```

3. Jalankan aplikasi
```bash
flutter run
```

## Build Release

### Universal APK (85.8 MB)
```bash
flutter build apk --release
```

### Split APK per arsitektur (53.5 MB - Recommended)
```bash
flutter build apk --split-per-abi
```

### App Bundle untuk Google Play Store
```bash
flutter build appbundle --release
```

## Struktur Proyek

```
Aplikasi-Kota-Pendekar/
│
├── android/                    # Konfigurasi Android native
├── ios/                        # Konfigurasi iOS native
│
├── assets/                     # Asset statis (34 MB)
│   ├── fonts/                  # Custom fonts
│   ├── icons/                  # App icons
│   ├── images/                 # UI images & banners
│   └── imgOpendata/            # Open data images
│
├── lib/                        # Source code Dart
│   ├── main.dart              # Entry point
│   ├── routes.dart            # App routes
│   ├── api/                   # API services
│   ├── constants/             # App constants
│   ├── daftarAplikasi/        # Menu aplikasi (50+ screens)
│   ├── homepage/              # Home screen
│   ├── screens/               # Main screens (berita, layanan, settings)
│   └── utils/                 # Helpers & utilities
│
├── pubspec.yaml               # Dependencies
└── README.md
```

## Kontribusi

Proyek ini dikembangkan sebagai bagian dari program magang di **Dinas Komunikasi dan Informatika Kota Madiun**.

## Lisensi

Proyek ini adalah milik Pemerintah Kota Madiun.

## Kontak

- Developer: [@arezyhs](https://github.com/arezyhs)
- Website: https://madiunkota.go.id
- Instagram: @pemkotmadiun_
