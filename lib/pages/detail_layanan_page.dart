import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pengajuan_cubit.dart';

class DetailLayananPage extends StatefulWidget {
  final Map<String, String> dataLayanan;
  const DetailLayananPage({super.key, required this.dataLayanan});

  @override
  State<DetailLayananPage> createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  bool _sedangMengirim = false; // State lokal dengan setState tetap dipertahankan

  void _ajukanPermohonan() async {
    final namaLayanan = widget.dataLayanan['nama'] ?? 'Layanan';

    setState(() => _sedangMengirim = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulasi pengiriman

    if (!mounted) return;

    // Menambahkan layanan menggunakan Cubit
    context.read<PengajuanCubit>().tambahPengajuan(namaLayanan);

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
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _sedangMengirim ? null : _ajukanPermohonan,
                child: _sedangMengirim
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Ajukan Permohonan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}