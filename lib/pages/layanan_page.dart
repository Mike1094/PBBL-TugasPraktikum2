import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

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
            tabs: [
              Tab(text: 'Perizinan'),
              Tab(text: 'Kesehatan'),
              Tab(text: 'Transportasi'),
            ],
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

  void _bukaDetail(BuildContext context, int index) async {
    final dataLayanan = {
      'nama': 'Layanan $kategori ${index + 1}',
      'dinas': 'Dinas $kategori Kota Nusantara',
      'jam': '08:00 - 15:00',
      'keterangan': 'Ini adalah deskripsi singkat mengenai layanan $kategori nomor ${index + 1}.',
    };

    final hasil = await Navigator.pushNamed(
      context,
      AppRoutes.detailLayanan,
      arguments: dataLayanan,
    );

    if (hasil != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(hasil.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.assignment),
          title: Text('Layanan $kategori ${index + 1}'),
          subtitle: Text('Dinas $kategori'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _bukaDetail(context, index),
        );
      },
    );
  }
}