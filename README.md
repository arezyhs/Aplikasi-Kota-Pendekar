# Aplikasi Kota Pendekar

Ringkasan singkat aplikasi mobile Flutter Smart Governance "Aplikasi Pendekar Kota Madiun".

**Project**: `Aplikasi-Kota-Pendekar`

**Tujuan**: Menyajikan layanan pemerintahan kota, daftar aplikasi, feed berita, dan fitur cepat (WhatsApp CTA, Radio). UI mobile-first untuk Android/iOS/web.

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

**Perubahan penting & catatan developer**
- News feed on Home (`NewsPreview`) sekarang menampilkan 3 item terbaru sebagai list (`ListTile`) — bukan lagi carousel. Ini mengurangi ruang kosong di bawah ketika melakukan scroll.
- Layanan utama (`_LayananUtama` in `home_screen.dart`) menampilkan tile bergaya card/InkWell, konsisten dengan `layanan_screen.dart`.
- Beberapa pages/webviews telah dimodifikasi untuk menggunakan AppBar actions (reload + open in external browser) dan untuk menghindari penggunaan `BuildContext` setelah `await` dengan cara menangkap `ScaffoldMessenger.of(context)` lebih awal atau menggunakan global navigator key pattern.
- Empty/unused carousels now return `SizedBox.shrink()` to avoid large empty slivers.

**Lint & style**
- Project masih memiliki sejumlah lints gaya (prefer_const_*, file_names) yang dapat diperbaiki bertahap. Saya merekomendasikan menjalankan `flutter analyze` lalu memperbaiki perubahan bergelombang (bulk small edits) untuk menghindari banyak edit-analyzing loops.