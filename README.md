Aplikasi Pendekar — Catatan Perubahan & Dokumentasi Pengembang
=============================================================

Versi dokumentasi: Fokus pada kronologi perubahan, detail perubahan kode, isu yang ditemui, dan langkah verifikasi.

Ringkasan
-----------------
Dokumen ini mencatat seluruh perubahan struktural dan fungsional yang dilakukan pada cabang kerja saat sesi refactor/UI perbaikan. Tujuannya: memberikan jejak yang jelas untuk review, QA, atau pengembangan lanjutan.

Konteks singkat proyek
---------------------
- Nama proyek: Aplikasi Pendekar (Madiun)
- Platform: Flutter (Dart)
- Fungsi: Portal layanan publik — menyatukan menu layanan (publik, kesehatan, pengaduan, ASN, CCTV, lainnya), berita, serta fitur informasi publik (PPID) dan pemutar radio. >> Intinya E-Governance.

Fokus Pengembangan Per 10/11/2025
----------------------------------
1. Membuat halaman terpisah untuk Layanan dan Berita.
2. Menyatukan komponen Home menjadi satu file layar (untuk konsistensi UI dan pengelolaan state).
2. Perbaiki UI/UX pada Layanan dan Berita agar seragam dengan Home.
3. Menghilangkan bug layout (terutama overflow pada featured services) dan mitigasi isu runtime yang mengganggu verifikasi visual.

Perubahan yang sudah dilakukan
--------------------------------------------

1) Penemuan & pembersihan awal
   - Menelusuri project untuk menemukan lokasi halaman Home, Layanan, dan Berita.
   - Menandai dan mengarsipkan file duplikat/legacy yang membingungkan (file duplikat dihapus oleh pemilik repo berdasarkan instruksi sebelumnya).

2) Refactor layar Layanan (`lib/screens/layanan/layanan_screen.dart`)
   - Hapus nested `Scaffold` yang menyebabkan double chrome.
   - Standarisasi AppBar (warna putih, teks tebal hitam, tanpa elevation) agar konsisten dengan Home.
   - Mempertahankan fitur Search; memperbaiki tampilan grid layanan: card lebih rapi, spacing seragam.
   - Memastikan navigasi menu membuka halaman yang benar (MaterialPageRoute ke widget target).

3) Refactor layar Berita (`lib/screens/berita/berita_screen.dart`)
   - Tambahkan `RefreshIndicator` untuk memudahkan refresh feed.
   - Tampilkan placeholder dan loading state saat mengunduh data.
   - Ganti pemanggilan URL ke yang lebih aman (gunakan `canLaunchUrl`/`launchUrl` bila memungkinkan).

4) Centralize AppBar di `HomePage`
   - Memindahkan AppBar ke satu tempat (shell `HomePage`) sehingga semua layar tab (Home, Layanan, Berita) menjadi body-only.
   - Keuntungan: konsistensi UI, navigasi back yang dapat dikelola dari satu tempat.

5) Konsolidasi Home (`lib/screens/home/home_screen.dart`)
   - Home dibuat single-file yang berisi komponen yang sebelumnya tersebar:
     * `HomeBanner` — banner penuh di atas.
     * Kategori (grid 2x4) — menampilkan utama 6-8 layanan.
     * Featured layanan (MBANGUN SWARGA, MANEKIN) — dipindahkan keluar dari grid menjadi scroller horizontal.
     * Informasi Publik / PPID — sebelumnya banner, sekarang card (dapat dibuat swipeable).
     * Radio player — komponen `HomePlayer` disimpan tetapi audio lifecycle diperbaiki kemudian.
     * Ringkasan Berita (top-3) + carousel.

   - Perubahan teknis utama pada Home:
     * Mengatur urutan sesuai permintaan UX: Banner → Kategori → Featured → PPID → Radio → Berita.
     * Memperbaiki overflow pada featured:
       - Ganti ukuran tetap (width 200, height 110) menjadi ukuran relatif: cardWidth = 45% layar, dibatasi 140–260 px.
       - Perkecil ikon di featured menjadi 56x56 dan gunakan `BoxDecoration` bundar langsung di card (jangan pakai `CircleCategory` yang lebih besar).
     * Menu grid disesuaikan menampilkan item yang benar (lihat daftar di bawah).

6) Penyesuaian kategori grid
   - Grid layanan kini hanya menampilkan (urut sesuai konfigurasi yang diminta):
     1. `Layanan Kesehatan` — `lib/homepage/menu/layanankesehatan.dart`
     2. `Layanan Publik` — `lib/homepage/menu/layananpublik.dart`
     3. `Layanan Pengaduan` — `lib/homepage/menu/layananpengaduan.dart`
     4. `Layanan Informasi` — `lib/homepage/menu/layananinformasi.dart`
     5. `Layanan ASN` — `lib/homepage/menu/layananAsn.dart`
     6. `CCTV` — rujukan di `lib/homepage/menu/lainnya.dart` (lihat catatan CCTV di sana)
     7. `Lainnya` — `lib/homepage/menu/lainnya.dart`

   - Dua layanan yang sebelumnya juga muncul di grid — `MBANGUN SWARGA` dan `MANEKIN` — dipindahkan ke area featured.

7) Informasi Publik (PPID)
   - PPID direpresentasikan sebagai card dengan image background (`assets/images/ppidbanner.png`).
   - Sesuai permintaan, PPID dapat dibuat swipeable (horizontal list of cards) — pada update ini diimplementasikan sebagai card; bisa diperluas menjadi scroller.

8) Radio / Audio
   - Komponen radio menggunakan `just_audio` dan `audio_session`.
   - Saat debugging ditemukan runtime exception terkait audio:
     "Invalid argument: Cannot complete a future with itself: Instance of 'Future<AudioPlayerPlatform>'"
   - Sampai perbaikan lifecycle dilakukan, beberapa mitigasi:
     * Menonaktifkan autoplay carousel.
     * Menambahkan pemeriksaan `mounted` sebelum `setState` pada callback async.
     * Opsi: sementara non-aktifkan `HomePlayer` agar `flutter run` berhasil meluncur untuk verifikasi UI.

9) Lain-lain
   - Mengoreksi duplikasi judul "Berita Terkini": memperkenalkan `HomeDescription` singkat sebagai pengantar sehingga tidak ada label ganda.
   - Memindahkan beberapa komponen Home yang bersifat spesifik ke dalam `lib/screens/home/home_screen.dart` untuk memudahkan maintenance.

Verifikasi & langkah pembangunan (developer)
-----------------------------------------
Langkah cepat untuk menjalankan dan memverifikasi perubahan (Windows PowerShell):

```powershell
flutter clean
flutter pub get
flutter analyze
flutter run
```

Catatan verifikasi:
- Jika `flutter run` gagal karena masalah audio, jalankan ulang setelah mengganti `HomePlayer` dengan placeholder sementara.

Analisa issues & technical debt
------------------------------
- Hasil `flutter analyze` menampilkan banyak isu (±900+), mayoritas berupa:
  - Deprecation notices (InAppWebView API lama, `launch`/`canLaunch` vs `launchUrl`).
  - Style hints (`prefer_const_constructors`, `use_key_in_widget_constructors`, `file_names` dan `camel_case_types`).
  - Unused imports.

- Rekomendasi: lakukan cleanup bertahap, fokus per folder atau per fitur supaya PR kecil mudah direview.

Decision log / alasan teknis penting
-----------------------------------
- Mengapa satukan Home jadi satu file?
  * Memudahkan penempatan widget yang hanya relevan pada Home dan mengurangi import-cascade di seluruh komponen.
  * Menjaga AppBar dan chrome UI konsisten.

- Kenapa tidak langsung perbaiki audio?
  * Audio lifecycle tersebar dan perbaikannya berisiko memengaruhi banyak file (dan berpotensi mengubah behaviour). Untuk memverifikasi UI lebih cepat, audio ditunda sementara.

Daftar file utama yang diubah (ringkasan)
---------------------------------------
- `lib/screens/home/home_screen.dart` — konsolidasi Home, perbaikan featured & grid.
- `lib/screens/layanan/layanan_screen.dart` — perbaikan UI Layanan.
- `lib/screens/berita/berita_screen.dart` — perbaikan UI Berita.
- `lib/homepage/views/components/home_description.dart` — perbaikan pengantar berita.
- `lib/homepage/views/components/circle_category.dart` — digunakan di grid; tetap dipertahankan.
- `lib/homepage/views/components/radio93fm.dart` — komponen radio (perlu audit lifecycle).

Next steps yang direkomendasikan
--------------------------------
1. Audit dan perbaiki audio lifecycle — tangani error Future/ownership di `just_audio`.
2. Pindahkan titik-titik deprecation/compatibility (upgrade `flutter_inappwebview` calls, `launchUrl` usage).
3. Lakukan refactoring style: tambahkan `const`, perbaiki `file_names`, hapus unused imports.
4. Tambahkan test widget (Home grid, featured scroller) supaya layout regression mudah dideteksi.

Catatan akhir
------------
Dokumentasi ini ditulis untuk developer yang akan melanjutkan pekerjaan pada repo ini. Bila Anda mau, saya bisa:

- Langsung perbaiki audio lifecycle (saya akan mengaudit `radio93fm.dart` dan `HomePlayer`), atau
- Mulai pembersihan analyzer per-folder, atau
- Buat PR terpisah untuk menyelesaikan styling dan konvensi kode.

Beritahu prioritas Anda, dan saya akan lanjutkan secara terstruktur.
# Aplikasi Pendekar

Dokumentasi ringkas dan kronologis perubahan pada proyek "Aplikasi Pendekar".

## Ringkasan proyek

`Aplikasi Pendekar` adalah aplikasi mobile berbasis Flutter yang berfungsi sebagai portal layanan publik dan informasi bagi warga. Aplikasi ini menyatukan beberapa layanan kota (layanan publik, layanan kesehatan, layanan pengaduan, CCTV, layanan ASN, dan lainnya), kanal berita, serta fitur audio/radio dan banner informasi publik.

Tujuan README ini: mencatat secara rinci apa saja yang telah diubah, diperbaiki, dan ditata ulang selama sesi refaktor dan perbaikan UI/UX sehingga konteks dapat ditinjau kembali, diverifikasi, atau dilanjutkan oleh pengembang lain.

## Platform & dependensi utama

- Bahasa: Dart
- Framework: Flutter
- Beberapa paket yang digunakan (tidak terbatas):
  - `http` — untuk fetch RSS/JSON berita
  - `url_launcher` — membuka URL eksternal (perlu migrasi ke `launchUrl` di beberapa tempat)
  - `carousel_slider` — carousel pada home
  - `just_audio`, `audio_session` — pemutar audio/radio (memerlukan audit lifecycle)
  - `flutter_inappwebview` dan turunan (ada deprecation warnings di project)

Perubahan bergantung pada konfigurasi yang ada di `pubspec.yaml` dan aset yang disimpan di folder `assets/` (terutama `assets/images/imgicon/` untuk ikon layanan).

## Struktur folder penting

- `lib/` — source utama
  - `main.dart` — entrypoint aplikasi
  - `screens/` — screen-level refactor (menampung `home`, `layanan`, `berita`)
  - `homepage/` — komponen dan menu yang lebih kecil (banner, carousel, kategori, dll.)
  - `daftarAplikasi/` — halaman-halaman aplikasi spesifik (mis. `mbangunswarga`, `manekin`, `ppid`)
  - `assets/` — gambar, ikon, font

## Tujuan perubahan selama sesi ini

Secara umum, pekerjaan difokuskan pada tiga hal:

1. Konsolidasi dan penyederhanaan halaman Home agar menjadi satu file layar (body-only) dan mengikuti chrome umum aplikasi (AppBar terpusat di `HomePage`).
2. Perbaikan UI/UX pada halaman `Layanan` dan `Berita` untuk konsistensi visual, spacing, dan penanganan navigasi.
3. Stabilitas runtime terkait timer/carousel dan mitigasi sementara pada audio/radio untuk memungkinkan verifikasi UI (perbaikan audio mendalam ditunda).

## Kronologi perubahan (runtut dan rinci)

Berikut urutan pekerjaan yang dilakukan, dari awal sampai status sekarang:

1. Penemuan & pemetaan
   - Mencari lokasi file yang berisi halaman Home, Layanan, Berita dan menelusuri wiring bottom navigation.
   - Menandai beberapa file duplikat/legacy.

2. Pembersihan awal
   - Mengarsipkan/menghapus file duplikat (oleh pengguna) untuk mengurangi kebingungan.

3. Refactor Layanan & Berita
   - Memindahkan/menyatukan layar `Layanan` ke `lib/screens/layanan/layanan_screen.dart`.
   - Memindahkan/menyatukan layar `Berita` ke `lib/screens/berita/berita_screen.dart`.
   - Dioptimalkan UI:
     - `Layanan`: hapus nested `Scaffold`, tambahkan header konsisten, perbaikan grid dan spacing.
     - `Berita`: loading state, `RefreshIndicator`, placeholder gambar, launching URL yang lebih aman.

4) NavBar (Bottom Navigation) & wiring tab
    - Dibuat dan/atau disesuaikan struktur navigasi bottom tab (NavBar) pada `HomePage`.
    - Implementasi singkat teknis:
       * `HomePage` menjaga sebuah `List<Widget>` (mis. `_pages = [HomeScreen(), LayananPage(), BeritaPage()]`) dan menampilkan salah satu berdasarkan index aktif.
       * BottomNavigationBar di-attach ke `HomePage` untuk berpindah antar-tab.
       * Navigasi back antar-tab diatur dengan sejarah internal (stack) sehingga tombol kembali berperilaku natural: kembali ke tab sebelumnya bila ada history.
    - Alasan & catatan:
       * Memisahkan halaman menjadi tab memberikan UX yang familiar (home/layanan/berita) dan memudahkan manajemen state per-tab.
       * Layanan dan Berita dibuat sebagai layar body-only (tanpa AppBar) supaya chrome konsisten (AppBar terpusat di `HomePage`).
    - Lokasi berkas utama:
       * `lib/main.dart` / `lib/screens/home/home_page.dart` (atau `HomePage` di `main.dart`) — tempat NavBar dan wiring tab dikelola.
       * `lib/screens/layanan/layanan_screen.dart` dan `lib/screens/berita/berita_screen.dart` — layar yang di-attach ke tab NavBar.

5. Centralize AppBar dan pola navigasi
   - AppBar dipusatkan di `HomePage`, sedangkan halaman layar dibuat body-only. Ini menjamin konsistensi chrome (warna, font, tombol kembali, dll.).
   - Navigasi back/tab history dikelola agar tombol kembali bersikap benar antar-tab.

6. Konsolidasi Home menjadi satu layar
   - Membuat `lib/screens/home/home_screen.dart` sebagai versi tunggal Home yang menggabungkan:
     - `HomeBanner` (banner penuh di atas)
     - Kategori / Layanan Utama (grid 2x4)
     - Featured layanan (kartu horizontal berisi `MBANGUN SWARGA` dan `MANEKIN`)
     - Informasi Publik / PPID (sebelumnya banner, lalu dibuat menjadi card swipeable)
     - Radio player (komponen `HomePlayer` yang tetap ada; audio lifecycle ditunda untuk perbaikan)
     - Ringkasan Berita Terbaru (top 3) + carousel berita

7. Perbaikan visual & layout Home
   - Memastikan urutan sesuai permintaan: Banner → Kategori (2x4) → Featured Layanan (geser horizontal) → PPID → Radio → Berita Terkini.
   - Mengatasi masalah overflow pada featured layanan:
     - Kartu featured kini memiliki lebar adaptif (45% layar, dibatasi) dan ikon diperkecil sehingga tidak menyebabkan overflow pada layar kecil.
   - Menghapus duplikasi judul "Berita Terkini" dengan mengganti bagian deskripsi berita agar menjadi kalimat pengantar singkat.

8. Penyesuaian kategori grid
   - Grid layanan diperbarui untuk hanya menampilkan:
     - `Layanan Kesehatan` (`layanankesehatan.dart`)
     - `Layanan Publik` (`layananpublik.dart`)
     - `Layanan Pengaduan` (`layananpengaduan.dart`)
     - `Layanan Informasi` (`layananinformasi.dart`)
     - `Layanan ASN` (`layananAsn.dart`)
     - `CCTV` (dilihat dari referensi di `lainnya.dart` dan dikaitkan)
     - `Lainnya` (`lainnya.dart`)
   - Featured layanan (`MBANGUN SWARGA`, `MANEKIN`) dipindahkan keluar dari grid dan ditampilkan dalam scroller khusus.

9. Informasi Publik (PPID)
   - PPID awalnya berada dalam banner; permintaan perubahan dibuat agar menjadi card yang dapat digeser/scroll horizontal (implementasi card swipeable diterapkan pada update ini).

10. Mitigasi runtime & analyzer
   - Mengurangi potensi timer-after-dispose pada carousel dengan menonaktifkan autoplay saat perlu.
   - Menambahkan pemeriksaan `mounted` saat memanggil `setState` dari callback async bila relevan.
   - Menjalankan `flutter analyze` mengungkap banyak isu lama (deprecations, unused imports, prefer_const, dll.). Banyak adalah peringatan/deprecation di seluruh proyek (±900+ pesan). Ini bukan hasil langsung perubahan Home tetapi pekerjaan pembersihan bisa dilakukan bertahap.

11. Audio / Radio (catatan penting)
   - `just_audio` dan `audio_session` digunakan untuk radio. Saat menjalankan `flutter run`, ditemukan exception runtime: "Invalid argument: Cannot complete a future with itself: Instance of 'Future<AudioPlayerPlatform>'".
   - Masalah ini menyebabkan `flutter run` terputus pada beberapa percobaan. Untuk memudahkan verifikasi UI, audio/radio ditangguhkan sementara atau mitigasi dipakai (mungkin menonaktifkan sementara `HomePlayer` bila diperlukan).
   - Perbaikan menyeluruh pada lifecycle audio ditandai sebagai tugas terpisah (belum diselesaikan karena resiko mengubah area banyak file).

## Perubahan file (ringkasan penting)

- `lib/screens/home/home_screen.dart` — file Home tunggal: menggabungkan banner, kategori (grid), featured scroller, PPID card, radio placeholder, dan preview berita.
- `lib/screens/layanan/layanan_screen.dart` — perbaikan UI Layanan (header, grid, navigasi).
- `lib/screens/berita/berita_screen.dart` — perbaikan UI Berita (loading, refresh, safe url launch).
- `lib/homepage/views/components/home_description.dart` — perbaikan untuk menghindari duplikat judul berita.
- `lib/homepage/views/components/circle_category.dart` — digunakan untuk ikon lingkaran di grid.
- `lib/homepage/views/components/radio93fm.dart` — komponen radio yang butuh audit lifecycle (ditandai sebagai deferred).
- `lib/daftarAplikasi/...` — beberapa halaman aplikasi spesifik (mis. `mbangunswarga.dart`, `manekin.dart`, `ppid.dart`) dirujuk oleh Home/Featured.

## Cara menjalankan (catatan untuk dev)

1. Pastikan Flutter SDK terpasang dan device/emulator tersedia.
2. Jalankan:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter run
```

Catatan: Pada beberapa percobaan, `flutter run` bisa berhenti karena masalah audio (lihat bagian Audio/Radio). Jika terjadi error audio pada runtime, jalankan ulang setelah sementara menonaktifkan `HomePlayer` di `lib/screens/home/home_screen.dart` (ganti widget dengan placeholder) untuk memverifikasi UI.

## Isu yang diketahui (dan prioritas perbaikan)

- Audio/Radio crash (tinggi): perbaiki ownership dan lifecycle `just_audio` untuk menghindari double-complete future.
- Banyak deprecation warnings dan style hints (sedang diberi label "technical debt"). Rekomendasi: migrasi `launch` -> `launchUrl`, perbarui API InAppWebView, hilangkan unused imports, dan tambahkan `const` di konstruktor yang relevan.
- Konsistensi nama file/kelas (sebagian masih menggunakan pola nama yang tidak sesuai pedoman Dart/Flutter seperti penggunaan huruf besar di nama file) — tidak blokir, tapi sebaiknya diseragamkan.

## Saran langkah lanjutan

1. Perbaiki audio lifecycle (prioritas tinggi) agar `flutter run` dapat berjalan stabil di device.
2. Lakukan pembersihan analyzer bertahap (ganti API deprecated, hapus unused imports, perbaikan style). Bagi perbaikan menjadi PR kecil per folder untuk memudahkan review.
3. Tambahkan tes widget sederhana untuk komponen kritis Home (grid, featured scroller) agar perubahan UI tidak merusak tata letak.
4. Dokumentasikan konvensi resource/asset (nama file ikon) agar tidak terjadi duplikasi atau kebingungan saat menambahkan ikon baru.

## Verifikasi yang sudah saya lakukan

- Menjalankan `flutter analyze` untuk mendeteksi isu (menemukan ~900 isu, mostly deprecations/warnings dari kode lama).
- Memperbaiki overflow pada featured layanan, dan menyesuaikan ukuran kartu supaya responsif.
- Menghapus duplikat judul berita.

## Penutup

README ini mencatat perubahan besar dan keputusan teknis selama sesi refactor yang bertujuan membuat Home konsisten, mengurangi aset duplikat, dan menstabilkan UI untuk pengujian lebih lanjut. 


# peceland

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
