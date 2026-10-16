import 'package:flutter_test/flutter_test.dart';
import 'package:viveroa/car_provider.dart';

void main() {
  test('el carrito mantiene cantidades por planta y total correcto', () {
    final carrito = CartProvider();

    carrito.agregarAlCarrito('Monstera');
    carrito.agregarAlCarrito('Monstera');
    carrito.agregarAlCarrito('Ficus');

    expect(carrito.cantidad, 3);
    expect(carrito.cantidadDe('Monstera'), 2);
    expect(carrito.cantidadDe('Ficus'), 1);

    carrito.eliminarDelCarrito('Monstera');
    expect(carrito.cantidadDe('Monstera'), 1);
    expect(carrito.cantidadDe('Ficus'), 1);
    expect(carrito.cantidad, 2);
  });

  test('no permite cantidades negativas ni elimina otra planta', () {
    final carrito = CartProvider();
    carrito.agregarAlCarrito('Ficus');

    carrito.eliminarDelCarrito('Monstera');
    expect(carrito.cantidad, 1);

    carrito.eliminarDelCarrito('Ficus');
    carrito.eliminarDelCarrito('Ficus');
    expect(carrito.cantidadDe('Ficus'), 0);
    expect(carrito.cantidad, 0);
  });
}
