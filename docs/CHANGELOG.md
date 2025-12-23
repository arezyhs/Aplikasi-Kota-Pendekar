# Changelog

Semua perubahan penting pada proyek ini akan didokumentasikan di file ini.

Format berdasarkan [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
dan proyek ini mengikuti [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.6] - 2025-12-24

### Changed - Major Refactoring
- **[BREAKING]** Restrukturisasi arsitektur ke Clean Architecture
  - Migrasi folder `/homepage` ke struktur profesional (`screens/`, `widgets/`, `utils/`)
  - Pisah `home_view.dart` menjadi `home_shell.dart` (navigasi) dan `home_screen.dart` (konten)
  - Reorganisasi 11 komponen ke folder `widgets/` dengan penamaan konsisten
  
- **Performance**
  - Reduksi 79% kode di home screen (1010 → 216 baris)
  - Ekstraksi `NewsPreviewWidget` (200 baris) untuk preview RSS feeds
  - Ekstraksi `LayananUtamaWidget` (380 baris) untuk grid layanan dan featured programs
  
- **Code Quality**
  - Implementasi separation of concerns
  - Penamaan konsisten: `home_caraousel` → `home_carousel`, `radio93fm` → `radio_player`
  - Update semua imports ke path baru
  - Clean architecture dengan layer yang jelas

- **Navigation**
  - Rename route: `HomePage` → `HomeShell` untuk clarity
  - Improved navigation history management di home shell

### Added
- 5 layanan screens baru di `screens/layanan/` dengan penamaan proper
  - `layanan_asn_screen.dart`
  - `layanan_publik_screen.dart`
  - `layanan_kesehatan_screen.dart`
  - `layanan_pengaduan_screen.dart`
  - `layanan_informasi_screen.dart`

### Documentation
- Update README.md struktur proyek untuk mencerminkan arsitektur baru
- Update README.md fitur section dengan detail yang lebih jelas
- Penambahan dokumentasi:
  - `docs/ARCHITECTURE.md` - Dokumentasi arsitektur lengkap
  - `docs/CONTRIBUTING.md` - Panduan kontribusi dan code standards
  - `docs/CHANGELOG.md` - File ini

### Fixed
- Splash screen tidak lagi full immersive mode (status bar & navigation bar visible)
- Import paths consistency setelah refactoring

---

## [1.2.5] - 2025-12-22

### Added
- Dark mode toggle di settings
- Aksesibilitas features:
  - Font size scaling
  - High contrast mode
- `ThemeProvider` untuk global theme management
- `AccessibilityProvider` untuk accessibility settings

### Changed
- Settings screen UI improvements
- Theme persistence dengan SharedPreferences

### Fixed
- Theme not persisting on app restart
- Accessibility settings not applying correctly

---

## [1.2.0] - 2025-12-15

### Added
- Radio streaming Suara Madiun 93FM
  - Live streaming dengan just_audio
  - Visualisasi audio waveform dengan siri_wave
  - Player controls (play/pause)
- Cache management untuk WebView
  - Local storage service
  - Cache clear functionality

### Changed
- Improved WebView performance dengan caching
- Better error handling untuk network requests

### Fixed
- WebView memory leaks
- Audio playback issues on app background

---

## [1.1.0] - 2025-12-01

### Added
- Feed berita dengan RSS aggregation
  - Agregasi dari 3 sumber (Instagram & Website)
  - Infinite scroll pagination
  - Fallback images untuk posts tanpa gambar
- Kategori layanan:
  - Layanan ASN (17 aplikasi)
  - Layanan Publik
  - Layanan Kesehatan
  - Layanan Pengaduan
  - Layanan Informasi

### Changed
- Improved grid layout untuk menu layanan
- Better image loading dengan cached_network_image

### Fixed
- RSS feed parsing errors
- Image loading timeout issues

---

## [1.0.0] - 2025-11-15

### Added
- Initial release
- Splash screen dengan animasi
- Beranda dengan banner carousel
- Grid menu 50+ layanan pemerintahan
- WebView integration untuk aplikasi internal
- Bottom navigation (Beranda, Layanan, Berita)
- Settings screen dengan:
  - Privacy policy
  - Terms & conditions
  - App information

### Features
- Portal layanan online terintegrasi
- Kategori aplikasi ASN dan Warga
- WebView caching untuk performance
- Deep linking support
- Permission handling untuk file access

---

## Format Template untuk Update Berikutnya

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- Fitur baru yang ditambahkan

### Changed
- Perubahan pada fitur existing

### Deprecated
- Fitur yang akan dihapus di versi future

### Removed
- Fitur yang dihapus

### Fixed
- Bug fixes

### Security
- Security fixes atau improvements
```

---

**Keterangan Versioning:**
- **MAJOR** (X.0.0) - Breaking changes, arsitektur besar
- **MINOR** (x.Y.0) - Fitur baru, backward compatible
- **PATCH** (x.y.Z) - Bug fixes, minor improvements
