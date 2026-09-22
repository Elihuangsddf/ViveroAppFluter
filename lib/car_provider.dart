import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _cantidad = 0;
  int get cantidad => _cantidad;

  void agregarAlCarrito() {
    _cantidad++;
    notifyListeners();
  }

  void eliminarDelCarrito() {
    if (_cantidad > 0) {
      _cantidad--;
      notifyListeners();
    }
  }
}