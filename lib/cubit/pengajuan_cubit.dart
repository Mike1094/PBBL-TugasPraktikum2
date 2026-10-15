import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<String>> {
  PengajuanCubit() : super([]);

  int get totalPengajuan => state.length;

  void tambahPengajuan(String namaLayanan) {
    final newState = List<String>.from(state)..add(namaLayanan);
    emit(newState);
  }
}