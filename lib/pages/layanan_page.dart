import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../navigation/app_routes.dart';
import '../cubit/favorit_cubit.dart';

// (Class LayananPage tetap sama persis)
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
          bottom: const TabBar(tabs: [Tab(text: 'Perizinan'), Tab(text: 'Kesehatan'), Tab(text: 'Transportasi')]),
        ),
        body: const TabBarView(
          children: [DaftarLayanan(kategori: 'Perizinan'), DaftarLayanan(kategori: 'Kesehatan'), DaftarLayanan(kategori: 'Transportasi')],
        ),
      ),
    );
  }
}

class DaftarLayanan extends StatelessWidget {
  final String kategori;
  const DaftarLayanan({super.key, required this.kategori});

  void _bukaDetail(BuildContext context, int index, String namaLayanan) async {
    final data = {'nama': namaLayanan, 'dinas': 'Dinas $kategori Kota Nusantara', 'jam': '08:00 - 15:00', 'keterangan': 'Ini adalah deskripsi singkat.'};
    final hasil = await Navigator.pushNamed(context, AppRoutes.detailLayanan, arguments: data);
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

        return BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, stateFavorit) {
            final isFavorit = stateFavorit.contains(namaLayanan);

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
                  if (isFavorit) {
                    context.read<FavoritCubit>().batalTandai(namaLayanan);
                  } else {
                    context.read<FavoritCubit>().tandai(namaLayanan);
                  }
                },
              ),
              onTap: () => _bukaDetail(context, index, namaLayanan),
            );
          },
        );
      },
    );
  }
}