import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, int> _cantidades = {};

  int get cantidad =>
      _cantidades.values.fold(0, (total, valor) => total + valor);

  int cantidadDe(String nombrePlanta) => _cantidades[nombrePlanta] ?? 0;

  void agregarAlCarrito(String nombrePlanta) {
    _cantidades[nombrePlanta] = cantidadDe(nombrePlanta) + 1;
    notifyListeners();
  }

  void eliminarDelCarrito(String nombrePlanta) {
    final cantidadActual = cantidadDe(nombrePlanta);
    if (cantidadActual == 0) return;

    if (cantidadActual == 1) {
      _cantidades.remove(nombrePlanta);
    } else {
      _cantidades[nombrePlanta] = cantidadActual - 1;
    }
    notifyListeners();
  }
}
