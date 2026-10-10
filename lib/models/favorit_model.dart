import 'package:flutter/material.dart';

class FavoritModel extends ChangeNotifier {
  final Set<String> _layananFavorit = {};

  List<String> get layananFavorit => _layananFavorit.toList();

  bool isFavorit(String namaLayanan) => _layananFavorit.contains(namaLayanan);

  void tandai(String namaLayanan) {
    _layananFavorit.add(namaLayanan);
    notifyListeners();
  }

  void batalTandai(String namaLayanan) {
    _layananFavorit.remove(namaLayanan);
    notifyListeners();
  }
}