import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation/app_routes.dart';
import '../models/favorit_model.dart';

// (Class LayananPage tetap sama persis seperti modul sebelumnya)
class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Layanan Publik'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [Tab(text: 'Perizinan'), Tab(text: 'Kesehatan'), Tab(text: 'Transportasi')],
          ),
        ),
        body: const TabBarView(
          children: [
            DaftarLayanan(kategori: 'Perizinan'),
            DaftarLayanan(kategori: 'Kesehatan'),
            DaftarLayanan(kategori: 'Transportasi'),
          ],
        ),
      ),
    );
  }
}

class DaftarLayanan extends StatelessWidget {
  final String kategori;
  const DaftarLayanan({super.key, required this.kategori});

  void _bukaDetail(BuildContext context, int index, String namaLayanan) async {
    final dataLayanan = {
      'nama': namaLayanan,
      'dinas': 'Dinas $kategori Kota Nusantara',
      'jam': '08:00 - 15:00',
      'keterangan': 'Ini adalah deskripsi singkat.',
    };

    final hasil = await Navigator.pushNamed(context, AppRoutes.detailLayanan, arguments: dataLayanan);

    if (hasil != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(hasil.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        final namaLayanan = 'Layanan $kategori ${index + 1}';

        // Membaca status favorit secara reaktif
        final isFavorit = context.watch<FavoritModel>().isFavorit(namaLayanan);

        return ListTile(
          leading: const Icon(Icons.assignment),
          title: Text(namaLayanan),
          subtitle: Text('Dinas $kategori'),
          trailing: IconButton(
            icon: Icon(
              isFavorit ? Icons.star : Icons.star_border,
              color: isFavorit ? Colors.orange : null,
            ),
            onPressed: () {
              // Melakukan pembaruan state
              if (isFavorit) {
                context.read<FavoritModel>().batalTandai(namaLayanan);
              } else {
                context.read<FavoritModel>().tandai(namaLayanan);
              }
            },
          ),
          onTap: () => _bukaDetail(context, index, namaLayanan),
        );
      },
    );
  }
}