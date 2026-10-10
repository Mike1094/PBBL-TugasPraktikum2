import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation/app_routes.dart';
import '../models/favorit_model.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Warga')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 16),
            const Text('Michael Eluzai Situmorang', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Program Studi: D4 Sistem Informasi Kota Cerdas'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.riwayat),
              icon: const Icon(Icons.history),
              label: const Text('Lihat Riwayat Laporan'),
            ),
            const Divider(height: 40),
            const Text('Layanan Favorit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Menampilkan daftar favorit reaktif
            Consumer<FavoritModel>(
              builder: (context, model, child) {
                if (model.layananFavorit.isEmpty) {
                  return const Text('Belum ada layanan yang ditandai.');
                }
                return Column(
                  children: model.layananFavorit
                      .map((layanan) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.star, color: Colors.orange),
                    title: Text(layanan),
                  ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}