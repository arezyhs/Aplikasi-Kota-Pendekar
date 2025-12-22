// ignore_for_file: prefer_const_constructors

// Data constants untuk layanan - centralized data management
import 'package:flutter/material.dart';
import 'package:pendekar/models/layanan_category.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/analisaberita.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/buktidukungspbe.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/carehub.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/digiform.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/dinsosapp.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/emonev.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/jdih.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/lppd.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/manekin.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/retribusi.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/ruangrapat.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/sicakep.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/silandep.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/simandor.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/simonev.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/siopa.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/sitebas.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/wbs.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/antrian_puskesmas.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/antrian_rs.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/awaksigap.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/esayur.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/madiuntoday.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/matawarga.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/ppid.dart';

class LayananData {
  LayananData._();

  // ===== LAYANAN UTAMA (Featured on Home Screen) =====
  static final List<LayananApp> layananUtama = [
    LayananApp(
      icon: "assets/images/imgicon/ekinerja.png",
      text: "EKINERJA",
      appId: "gov.madiun.ekin_madiun_andro",
      uriScheme: "ekinerja://",
    ),
    LayananApp(
      icon: "assets/images/imgicon/buktidukungspbe.png",
      text: "BUKTI DUKUNG SPBE",
      page: WebSpbe(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/bakul.png",
      text: "J.D.I.H",
      page: WebJdih(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/carehub.png",
      text: "CAREHUB",
      page: WebCarehub(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/proumkm.png",
      text: "PROUMKM",
      appId: "com.kominfo.proumkm",
      uriScheme: "proumkm://",
    ),
    LayananApp(
      icon: "assets/images/imgicon/lppd.png",
      text: "LPPD",
      page: WebLppd(),
    ),
  ];

  // ===== ALL APPS BY CATEGORY =====

  // Layanan ASN - Full list
  static final List<LayananApp> asnApps = [
    LayananApp(
      icon: "assets/images/imgicon/ekinerja.png",
      text: "EKINERJA",
      appId: "gov.madiun.ekin_madiun_andro",
      uriScheme: "ekinerja://",
    ),
    LayananApp(
      icon: "assets/images/imgicon/buktidukungspbe.png",
      text: "BUKTI DUKUNG SPBE",
      page: WebSpbe(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/bakul.png",
      text: "J.D.I.H",
      page: WebJdih(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/digiform.png",
      text: "DIGIFORM DUKCAPIL",
      page: WebDigiform(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/emonev.png",
      text: "EMONEV",
      page: WebEmonev(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/manekin.png",
      text: "MANEKIN",
      page: WebManekin(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/carehub.png",
      text: "CAREHUB",
      page: WebCarehub(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/dinsos.png",
      text: "DINSOS APP",
      page: WebDinsosapp(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/proumkm.png",
      text: "PROUMKM",
      appId: "com.kominfo.proumkm",
      uriScheme: "proumkm://",
    ),
    LayananApp(
      icon: "assets/images/imgicon/lppd.png",
      text: "LPPD",
      page: WebLppd(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/matawarga.png",
      text: "MATAWARGA",
      page: WebMatawarga(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/retribusi.png",
      text: "RETRIBUSI",
      page: WebRetribusi(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/ruangrapat.png",
      text: "RUANG RAPAT",
      page: WebRuangrapat(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/simandor.png",
      text: "SIMANDOR",
      page: WebSimandor(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/simonev.png",
      text: "SIMONEV",
      page: WebSimonev(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/siopa.png",
      text: "SIOPA",
      page: WebSiopa(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/silandep.png",
      text: "SILANDEP",
      page: WebSilandep(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/sitebas.png",
      text: "SITEBAS",
      page: WebSitebas(),
    ),
  ];

  // Layanan Publik
  static final List<LayananApp> publikApps = [
    LayananApp(
      icon: "assets/images/imgicon/pasaremadiun.png",
      text: "PASAR E-MADIUN",
      appId: "com.kominfo.pasar_emadiun",
      uriScheme: "com.kominfo.pasar_emadiun://",
    ),
    LayananApp(
      icon: "assets/images/imgicon/bookingprc.png",
      text: "Booking PRC",
      appId: "com.kominfo.bookingprc",
      uriScheme: "bookingprc://",
    ),
    LayananApp(
      icon: "assets/images/imgicon/esayur.png",
      text: "ESAYUR",
      page: WebEsayur(),
    ),
  ];

  // Layanan Pengaduan
  static final List<LayananApp> pengaduanApps = [
    LayananApp(
      icon: "assets/images/imgicon/wbs.png",
      text: "WBS KOTA MADIUN",
      page: WebWbs(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/awaksigap.png",
      text: "AWAK SIGAP",
      page: WebAwaksigap(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/ppid.png",
      text: "PPID",
      page: WebPpid(),
    ),
  ];

  // Layanan Kesehatan
  static final List<LayananApp> kesehatanApps = [
    LayananApp(
      icon: "assets/images/imgicon/rumahsakit.png",
      text: "ANTRIAN RUMAH SAKIT",
      page: WebAntrianRS(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/puskesmas.png",
      text: "ANTRIAN PUSKESMAS",
      page: WebAntrianPuskesmas(),
    ),
  ];

  // Layanan Informasi
  static final List<LayananApp> informasiApps = [
    LayananApp(
      icon: "assets/images/imgicon/analisaberita.png",
      text: "ANALISA BERITA",
      page: WebAnalisaberita(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/madiuntoday.png",
      text: "MADIUNTODAY",
      page: WebMadiun(),
    ),
    LayananApp(
      icon: "assets/images/imgicon/sicakep.png",
      text: "AGENDA KOTA MADIUN",
      page: WebSicakep(),
    ),
  ];

  // ===== CATEGORIES FOR LAYANAN PAGE =====
  static final List<LayananCategory> categories = [
    LayananCategory(
      id: 'publik',
      title: 'Layanan Publik',
      icon: Icons.public,
      apps: publikApps,
    ),
    LayananCategory(
      id: 'pengaduan',
      title: 'Layanan Pengaduan',
      icon: Icons.report,
      apps: pengaduanApps,
    ),
    LayananCategory(
      id: 'kesehatan',
      title: 'Layanan Kesehatan',
      icon: Icons.local_hospital,
      apps: kesehatanApps,
    ),
    LayananCategory(
      id: 'informasi',
      title: 'Layanan Informasi',
      icon: Icons.info,
      apps: informasiApps,
    ),
    LayananCategory(
      id: 'asn',
      title: 'Layanan ASN',
      icon: Icons.apps,
      apps: asnApps,
    ),
  ];
}
