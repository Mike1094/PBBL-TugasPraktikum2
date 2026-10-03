import 'package:flutter/material.dart';

class DetailLayananPage extends StatelessWidget {
  final Map<String, String> dataLayanan;

  const DetailLayananPage({super.key, required this.dataLayanan});

  @override
  Widget build(BuildContext context) {
    final namaLayanan = dataLayanan['nama'] ?? 'Tidak diketahui';

    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Layanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(namaLayanan, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('Penanggung Jawab: ${dataLayanan['dinas']}'),
            Text('Jam Operasional: ${dataLayanan['jam']}'),
            const SizedBox(height: 16),
            const Text('Keterangan:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(dataLayanan['keterangan'] ?? '-'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Permohonan $namaLayanan telah diajukan');
                },
                child: const Text('Ajukan Permohonan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}