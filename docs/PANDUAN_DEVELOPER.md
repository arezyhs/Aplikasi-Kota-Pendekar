# Panduan Developer - Aplikasi Kota Pendekar

## Cara Menambah Aplikasi Baru

### TIPE 1: Aplikasi WebView (Aplikasi Internal)

**Contoh: Menambah aplikasi "SIMPEG" ke kategori ASN**

#### Langkah 1: Buat File Widget
Lokasi: `lib/daftarAplikasi/aplikasi ASN/simpeg.dart`

```dart
import 'package:flutter/material.dart';
import 'package:pendekar/utils/services/app_config.dart';
import 'package:pendekar/utils/web_container_page.dart';

class WebSimpeg extends StatelessWidget {
  const WebSimpeg({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWebViewPage(
      url: AppConfig.getAsnAppUrl('simpeg'),
      title: 'SIMPEG',
    );
  }
}
```

#### Langkah 2: Tambahkan URL
File: `lib/utils/services/app_config.dart`

Cari bagian `_asnApps` dan tambahkan:

```dart
static const Map<String, String> _asnApps = {
  // ... aplikasi yang sudah ada ...
  'simpeg': 'https://simpeg.madiunkota.go.id/',
  // ... sisanya ...
};
```

#### Langkah 3: Daftarkan di Data
File: `lib/constants/layanan_data.dart`

**3a. Tambahkan import di bagian atas:**
```dart
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/simpeg.dart';
```

**3b. Tambahkan ke list `asnApps`:**
```dart
static final List<LayananApp> asnApps = [
  // ... aplikasi yang sudah ada ...
  LayananApp(
    icon: "assets/images/imgicon/simpeg.png",  // Siapkan icon dulu!
    text: "SIMPEG",
    page: WebSimpeg(),
  ),
  // ... sisanya ...
];
```

#### Langkah 4 (Opsional): Tampilkan di Beranda
Jika ingin muncul di "Layanan Utama" halaman beranda:

```dart
static final List<LayananApp> layananUtama = [
  // ... aplikasi yang sudah ada ...
  LayananApp(
    icon: "assets/images/imgicon/simpeg.png",
    text: "SIMPEG",
    page: WebSimpeg(),
  ),
];
```

**SELESAI!** Aplikasi akan otomatis muncul di:
- Menu "Layanan ASN"
- Tab "Layanan" kategori ASN
- Beranda "Layanan Utama" (jika ditambahkan di langkah 4)

---

### TIPE 2: Aplikasi External (dari Play Store)

**Contoh: Menambah aplikasi yang sudah ada di Play Store**

File: `lib/constants/layanan_data.dart`

```dart
static final List<LayananApp> publikApps = [
  // ... aplikasi yang sudah ada ...
  LayananApp(
    icon: "assets/images/imgicon/myapp.png",
    text: "NAMA APLIKASI",
    appId: "com.example.myapp",        // Package name dari Play Store
    uriScheme: "myapp://",             // URL scheme aplikasi
  ),
];
```

**Cara kerja:**
1. Coba buka aplikasi pakai `uriScheme`
2. Jika aplikasi belum terinstall → Muncul pesan error
3. User bisa install manual dari Play Store

---

## Struktur File

```
lib/
├── constants/
│   └── layanan_data.dart              ← EDIT DI SINI! (Data semua aplikasi)
│
├── daftarAplikasi/
│   ├── aplikasi ASN/                  ← Buat widget aplikasi ASN di sini
│   │   ├── simpeg.dart
│   │   └── jdih.dart
│   └── aplikasi warga/                ← Buat widget aplikasi warga di sini
│       ├── ppid.dart
│       └── esayur.dart
│
├── models/
│   ├── layanan_category.dart          ← Model kategori layanan
│   └── policy_section.dart            ← Model section policy
│
├── providers/
│   ├── theme_provider.dart            ← State management theme
│   └── accessibility_provider.dart    ← State management aksesibilitas
│
├── utils/services/
│   └── app_config.dart                ← Tambahkan URL di sini
│
└── widgets/
    ├── layanan_search_widget.dart     ← Search bar component
    ├── layanan_filter_widget.dart     ← Filter chips component
    └── policy_page_widget.dart        ← Generic policy page
```

---

## Kategori Aplikasi

Ada 5 kategori:

1. **ASN** - Aplikasi untuk Aparatur Sipil Negara
   - List: `asnApps` di `layanan_data.dart`
   - Folder: `lib/daftarAplikasi/aplikasi ASN/`

2. **Publik** - Layanan untuk masyarakat umum
   - List: `publikApps` di `layanan_data.dart`
   - Folder: `lib/daftarAplikasi/aplikasi warga/`

3. **Pengaduan** - Aplikasi pengaduan masyarakat
   - List: `pengaduanApps` di `layanan_data.dart`
   - Folder: `lib/daftarAplikasi/aplikasi warga/`

4. **Kesehatan** - Layanan kesehatan
   - List: `kesehatanApps` di `layanan_data.dart`
   - Folder: `lib/daftarAplikasi/aplikasi warga/`

5. **Informasi** - Informasi publik
   - List: `informasiApps` di `layanan_data.dart`
   - Folder: `lib/daftarAplikasi/aplikasi warga/`

---

## Checklist Sebelum Submit

- [ ] Icon sudah ada di `assets/images/imgicon/`
- [ ] File widget sudah dibuat
- [ ] URL sudah ditambahkan di `app_config.dart`
- [ ] Import sudah ditambahkan di `layanan_data.dart`
- [ ] Aplikasi sudah ditambahkan ke kategori yang sesuai
- [ ] Test navigasi dari menu
- [ ] Test WebView bisa dibuka
- [ ] Test tombol back berfungsi

---

## Troubleshooting

**Aplikasi tidak muncul di menu:**
- Cek import di `layanan_data.dart` sudah benar
- Jalankan `flutter clean` dan `flutter pub get`
- Restart aplikasi (bukan hot reload)

**WebView tidak bisa dibuka:**
- Cek URL di `app_config.dart` sudah benar
- Pastikan koneksi internet aktif
- Pastikan URL pakai HTTPS

**Icon tidak muncul:**
- Cek path icon sudah benar
- Cek file icon ada di folder `assets/images/imgicon/`
- Jalankan `flutter pub get`

---

**Terakhir diupdate:** 22 Desember 2025