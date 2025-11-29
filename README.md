# Aplikasi Pendekar Kota Madiun (Peceland)

Aplikasi mobile smart governance untuk layanan pemerintahan Kota Madiun.

## Deskripsi

Aplikasi berbasis Flutter yang memberikan akses mudah kepada warga untuk menggunakan layanan pemerintahan, berita, dan informasi kota. Aplikasi ini menampilkan antarmuka yang modern dan user-friendly dengan integrasi layanan web dan update real-time.

## Fitur

- **Layanan Pemerintahan** - Akses ke berbagai layanan dan aplikasi kota
- **Feed Berita** - Berita terbaru dan pengumuman dari pemerintah kota
- **Aksi Cepat** - Akses langsung ke dukungan WhatsApp dan streaming radio
- **Multi-platform** - Tersedia untuk Android, iOS, dan web

## Memulai

### Persyaratan
- Flutter SDK (versi stabil terbaru)
- Android Studio / VS Code dengan ekstensi Flutter

### Instalasi

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

### Build untuk Release

```bash
# Android APK
flutter build apk --release

# Web
flutter build web
```

## Struktur Proyek

```
lib/
├── main.dart           # Entry point aplikasi
├── screens/            # Layar UI
├── api/               # Layanan API
├── constants/         # Konstanta aplikasi
└── utils/            # Fungsi utility
```

## Kontribusi

Proyek ini merupakan bagian dari magang di Dinas Komunikasi dan Informatika Kota Madiun.