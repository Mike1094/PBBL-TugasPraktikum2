import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';

class DetailLayananPage extends StatefulWidget {
  final Map<String, String> dataLayanan;

  const DetailLayananPage({super.key, required this.dataLayanan});

  @override
  State<DetailLayananPage> createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  bool _sedangMengirim = false;

  void _ajukanPermohonan() async {
    final namaLayanan = widget.dataLayanan['nama'] ?? 'Layanan';

    // 1. Mulai status loading (state lokal)
    setState(() {
      _sedangMengirim = true;
    });

    // 2. Simulasi proses pengiriman data
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // 3. Simpan ke PengajuanModel (state global)
    context.read<PengajuanModel>().tambahPengajuan(namaLayanan);

    // 4. Tutup halaman dan kirim notifikasi
    Navigator.pop(context, 'Permohonan $namaLayanan telah diajukan');
  }

  @override
  Widget build(BuildContext context) {
    final namaLayanan = widget.dataLayanan['nama'] ?? 'Tidak diketahui';

    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Layanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(namaLayanan, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('Penanggung Jawab: ${widget.dataLayanan['dinas']}'),
            Text('Jam Operasional: ${widget.dataLayanan['jam']}'),
            const SizedBox(height: 16),
            const Text('Keterangan:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.dataLayanan['keterangan'] ?? '-'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _sedangMengirim ? null : _ajukanPermohonan,
                child: _sedangMengirim
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Text('Ajukan Permohonan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}