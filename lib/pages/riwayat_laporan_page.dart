import 'package:flutter/material.dart';

class RiwayatLaporanPage extends StatelessWidget {
  const RiwayatLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Laporan')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(
          title: Text('Laporan ${index + 1}'),
          subtitle: const Text('Status: Selesai ditangani'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
            IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
            IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}