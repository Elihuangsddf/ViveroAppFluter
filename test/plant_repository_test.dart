import 'package:flutter_test/flutter_test.dart';
import 'package:viveroa/plant_repository.dart';

void main() {
  final repository = PlantRepository();

  test('la búsqueda ignora acentos y mayúsculas', () {
    final resultados = repository.buscarPlantas(
      categoria: 'Todas',
      texto: '  ORQUIDEA  ',
    );

    expect(
      resultados.map((planta) => planta.nombre),
      contains('Orquídea Phalaenopsis'),
    );
  });

  test('encuentra palabras clave y combina el filtro de categoría', () {
    final interior = repository.buscarPlantas(
      categoria: 'Interior',
      texto: 'lengua de suegra',
    );
    final exterior = repository.buscarPlantas(
      categoria: 'Exterior',
      texto: 'lengua de suegra',
    );

    expect(interior.map((planta) => planta.nombre), contains('Sansevieria'));
    expect(exterior, isEmpty);
  });

  test('los espacios vacíos muestran todas las plantas de la categoría', () {
    final resultados = repository.buscarPlantas(
      categoria: 'Exterior',
      texto: '   ',
    );

    expect(resultados, isNotEmpty);
    expect(
      resultados.every((planta) => planta.categorias == 'Exterior'),
      isTrue,
    );
  });

  test('detalle y catálogo obtienen la misma planta', () {
    final planta = repository
        .buscarPlantas(categoria: 'Todas', texto: 'monstera')
        .single;

    expect(repository.obtenerPlantaPorNombre(planta.nombre), same(planta));
    expect(repository.obtenerPlantaPorNombre('Inexistente'), isNull);
  });
}
