import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, int> _cantidades = {};

  int get cantidad =>
      _cantidades.values.fold(0, (total, valor) => total + valor);

  int cantidadDe(String plantaId) => _cantidades[plantaId] ?? 0;

  void agregarAlCarrito(String plantaId) {
    _cantidades[plantaId] = cantidadDe(plantaId) + 1;
    notifyListeners();
  }

  void eliminarDelCarrito(String plantaId) {
    final cantidadActual = cantidadDe(plantaId);
    if (cantidadActual == 0) return;

    if (cantidadActual == 1) {
      _cantidades.remove(plantaId);
    } else {
      _cantidades[plantaId] = cantidadActual - 1;
    }
    notifyListeners();
  }
}
