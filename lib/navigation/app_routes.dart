import 'package:flutter/material.dart';
import '../navigation/kerangka_navigasi.dart';
import '../pages/detail_layanan_page.dart';
import '../pages/riwayat_laporan_page.dart';
import '../pages/pengaturan_kota_page.dart';
import '../pages/tentang_aplikasi_page.dart';
import '../pages/unknown_route_page.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail-layanan';
  static const String riwayat = '/riwayat-laporan';
  static const String pengaturan = '/pengaturan';
  static const String tentang = '/tentang';
  static const String testRouteSalah = '/rute-palsu';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      riwayat: (context) => const RiwayatLaporanPage(),
      pengaturan: (context) => const PengaturanKotaPage(),
      tentang: (context) => const TentangAplikasiPage(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLayanan) {
      final args = settings.arguments as Map<String, String>;
      return MaterialPageRoute(
        builder: (context) => DetailLayananPage(dataLayanan: args),
      );
    }
    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const UnknownRoutePage(),
    );
  }
}