import 'package:flutter_test/flutter_test.dart';
import 'package:viveroa/plant_model.dart';

void main() {
  test('convierte un documento de Firestore con campos en español', () {
    final planta = Plant.fromMap('abc123', {
      'nombre': '  Monstera  ',
      'precio': 20,
      'rutaImagen': 'ImgPlants/01-monstera-deliciosa.png',
      'categoria': 'Interior',
      'descripcion': 'Hojas grandes y recortadas.',
      'luz': 'Luz indirecta.',
      'riego': 'Cuando la tierra esté seca.',
      'palabrasClave': ['costilla de adan', 'hojas grandes'],
    });

    expect(planta.id, 'abc123');
    expect(planta.nombre, 'Monstera');
    expect(planta.precio, 20);
    expect(planta.categoria, 'Interior');
    expect(planta.descripcion, 'Hojas grandes y recortadas.');
    expect(planta.luz, 'Luz indirecta.');
    expect(planta.riego, 'Cuando la tierra esté seca.');
    expect(planta.palabrasClave, contains('costilla de adan'));
    expect(planta.precioTexto, '\$20.00');
  });

  test('acepta campos alternativos y precios escritos como texto', () {
    final planta = Plant.fromMap('xyz', {
      'name': 'Olivo',
      'price': '62,50',
      'imageUrl': 'https://ejemplo.com/olivo.png',
      'category': 'Exterior',
      'description': 'Árbol mediterráneo.',
      'keywords': ['aceituna', 'sol'],
    });

    expect(planta.nombre, 'Olivo');
    expect(planta.precio, 62.5);
    expect(planta.rutaImagen, 'https://ejemplo.com/olivo.png');
    expect(planta.categoria, 'Exterior');
    expect(planta.palabrasClave, ['aceituna', 'sol']);
  });

  test('usa valores por defecto cuando faltan datos obligatorios', () {
    final planta = Plant.fromMap('sin-datos', {});

    expect(planta.nombre, 'Nombre desconocido');
    expect(planta.categoria, 'Sin categoría');
    expect(planta.precio, 0);
    expect(planta.descripcion, isEmpty);
    expect(planta.palabrasClave, isEmpty);
  });
}
