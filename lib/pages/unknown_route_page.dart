import 'package:flutter/material.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rute Tidak Ditemukan')),
      body: const Center(child: Text('Maaf, halaman yang Anda cari tidak ada.')),
    );
  }
}