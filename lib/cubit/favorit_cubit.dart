import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super({});

  void tandai(String namaLayanan) {
    // Membuat salinan state lama, menambah data baru, lalu me-ngirimkannya (emit)
    final newState = Set<String>.from(state)..add(namaLayanan);
    emit(newState);
  }

  void batalTandai(String namaLayanan) {
    // Membuat salinan state lama, menghapus data, lalu me-ngirimkannya (emit)
    final newState = Set<String>.from(state)..remove(namaLayanan);
    emit(newState);
  }
}