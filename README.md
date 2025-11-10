Aplikasi Pendekar — Dokumentasi Perubahan & Petunjuk Verifikasi
===============================================================

Ringkasan singkat
-----------------
Dokumentasi ini merangkum perubahan struktural, perbaikan UI/UX, dan temuan teknis yang dilakukan selama sesi refactor dan stabilisasi pada proyek "Aplikasi Pendekar". Dokumen ditulis untuk keperluan laporan magang dan sebagai panduan teknis.

Konsep dan konteks singkat
-------------------------
- Proyek  : Aplikasi Pendekar (Madiun)
- Teknologi: Flutter (Dart)
- Tujuan  : portal layanan publik (layanan pemerintahan, berita, informasi publik, radio)

Ringkasan perubahan utama
-------------------------
- Membuat, menemukan, merapikan, dan memindahkan layar utama ke struktur `lib/screens/`.
- Mengonsolidasikan Home menjadi satu layar: `lib/screens/home/home_screen.dart`.
- Memusatkan AppBar pada shell `HomePage`, sehingga tiap tab menjadi body-only.
- Refactor layar `Layanan` dan `Berita` untuk konsistensi UI dan pengalaman pengguna.
- Memperbaiki overflow pada featured services dengan ukuran adaptif.
- Mitigasi masalah runtime (audio & carousel) untuk memungkinkan verifikasi UI.
- Menambahkan `.gitattributes` dan memperbarui `.gitignore`; menormalisasi line endings.

Detail perubahan — kronologi dan teknis
-------------------------------------

1) Penelusuran & pembersihan
  - Menelusuri project untuk menemukan lokasi layar Home, Layanan, dan Berita.
  - Menandai file duplikat/legacy. Beberapa file diarsipkan atau dihapus oleh pemilik repo.

2) Centralize AppBar dan navigasi tab
  - AppBar dipindahkan atau dikendalikan dari satu tempat (shell `HomePage`).
  - BottomNavigationBar / tab wiring diatur supaya tiap layar menjadi body-only; back navigation antar-tab dikelola.

3) Perombakan Home
  - File utama: `lib/screens/home/home_screen.dart` menyatukan komponen Home yang sebelumnya tersebar.
  - Urutan konten Home diatur sesuai permintaan UX:
    * Banner
    * Kategori (grid 2x4)
    * Featured layanan (horizontal scroller)
    * PPID (Informasi Publik) — card
    * Radio (HomePlayer; lifecycle di-audit terpisah)
    * Berita terkini (preview top-3 + carousel)

  - Perbaikan featured services:
    * Ganti ukuran tetap menjadi relatif: cardWidth = 45% lebar layar, dibatasi 140–260 px.
    * Ikon featured diperkecil (sekitar 56x56) dan menggunakan dekorasi bundar di dalam kartu.

4) Layanan (refactor)
  - File: `lib/screens/layanan/layanan_screen.dart`.
  - Membuat halaman Layanan yang berisi seluruh aplikasi yang ada.
  - Menghapus nested `Scaffold` yang menyebabkan double chrome.
  - Standarisasi AppBar (warna, teks, elevasi) dan perbaikan grid layanan.
  - Pencarian (search) tetap ada dan ditata ulang untuk konsistensi.

5) Berita (refactor)
  - File: `lib/screens/berita/berita_screen.dart`.
  - Membuat halaman berita yang berisi berita terbaru.
  - Tambah `RefreshIndicator`, state loading/placeholder, dan penggunaan URL launcher yang lebih aman bila memungkinkan.
  - Up to date dengan RSS yang ditembak.

6) PPID
  - Representasi PPID sebagai card dengan background image (`assets/images/ppidbanner.png`).
  - Desain dilakukan agar mudah dikembangkan menjadi swipeable cards.

7) Radio / Audio (temuan penting)
  - Implementasi audio menggunakan `just_audio` dan `audio_session`.
  - Ditemukan runtime exception saat pengujian:
    "Invalid argument: Cannot complete a future with itself: Instance of 'Future<AudioPlayerPlatform>'".
  - Mitigasi sementara:
    * Nonaktifkan autoplay carousel yang menimbulkan timer-after-dispose.
    * Tambahkan pemeriksaan `mounted` sebelum `setState` pada callback async.
    * Opsi sementara: ganti `HomePlayer` dengan placeholder untuk memungkinkan `flutter run` berjalan saat verifikasi UI.

8) Git dan pengaturan repo
  - Tambah `.gitattributes` untuk normalisasi CRLF/LF.
  - Perbarui `.gitignore` ke template Flutter.
  - Dilakukan renormalisasi line endings dan commit terkait.

Daftar file utama yang diubah
----------------------------
- `lib/screens/home/home_screen.dart` — konsolidasi Home
- `lib/screens/layanan/layanan_screen.dart` — refactor Layanan
- `lib/screens/berita/berita_screen.dart` — refactor Berita
- `lib/homepage/views/components/home_description.dart` — pengantar berita (menghindari duplikasi judul)
- `lib/homepage/views/components/circle_category.dart` — komponen ikon kategori (dipertahankan)
- `lib/homepage/views/components/radio93fm.dart` — komponen radio (perlu audit lifecycle)
- `lib/daftarAplikasi/` — beberapa halaman rujukan seperti `mbangunswarga.dart`, `manekin.dart`, `ppid.dart`
- `.gitattributes`, `.gitignore` — konfigurasi repo

Known issues & rekomendasi perbaikan
----------------------------------

1) Analyzer warnings & deprecated APIs — Prioritas sedang
   - Temuan: `flutter analyze` menghasilkan banyak peringatan (±900 pesan) — deprecations, prefer_const, unused imports, nama file/kelas tidak konsisten.
   - Rekomendasi: migrasi bertahap per-folder; prioritaskan API yang benar-benar deprecated (mis. InAppWebView changes, `launch` → `launchUrl`).

2) Tests dan regresi
   - Belum disertakan test otomatis khusus. Rekomendasi: tambahkan 1-2 widget test untuk grid kategori dan featured scroller.

Cara menjalankan & verifikasi (Windows PowerShell)
------------------------------------------------
Langkah singkat:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter run
```

Checklist verifikasi minimal (lakukan pemeriksaan ini manual pada device/emulator):

1. Home
   - Banner tampil di bagian atas.
   - Grid kategori menampilkan 2x4 item sesuai daftar layanan.
   - Featured layanan tampil horizontal dan tidak overflow pada layar kecil.

2. Layanan
   - Grid tampak rapi, pencarian berfungsi, navigasi item membuka halaman yang benar.

3. Berita
   - Halaman dapat direfresh dengan `RefreshIndicator`.
   - Tautan berita berusaha dibuka menggunakan API launcher yang aman.

4. PPID
   - Card PPID muncul dan dapat diklik (navigasi sesuai implementasi target).

5. Radio
   - Jika aktif, radio harus memutar tanpa menyebabkan crash; jika crash terjadi, kembalikan ke placeholder untuk verifikasi UI.

Quality gates singkat
---------------------
- Lint/Analyze: terdapat banyak warning/deprecation (STATUS: FAIL untuk zero-issue goal).
- Tests: belum ada tests otomatis yang relevan (STATUS: MISSING).

Next steps terstruktur (prioritas)
--------------------------------
1. Migrasi API yang deprecated (`url_launcher`, `flutter_inappwebview`) dan perbaiki peringatan analyzer kritis (menengah).
2. Melakukan pembersihan style (seperti menambahkan `const`, menghapus unused imports, perbaiki penamaan file/kelas) per-folder, PR kecil.
4. Menambahkan widget test untuk Home grid & featured scroller.


Penutup
-------
Dokumen ini disusun sebagai bahan laporan magang dan panduan teknis.