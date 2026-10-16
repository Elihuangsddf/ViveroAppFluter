import 'plant_model.dart';

class PlantRepository {
  List<Plant> obtenerPlantas() => plantasDemo;

  Plant? obtenerPlantaPorNombre(String nombre) {
    for (final planta in obtenerPlantas()) {
      if (planta.nombre == nombre) return planta;
    }
    return null;
  }

  List<Plant> buscarPlantas({
    required String categoria,
    required String texto,
  }) {
    final palabras = _normalizar(
      texto,
    ).split(RegExp(r'\s+')).where((palabra) => palabra.isNotEmpty);

    return obtenerPlantas().where((planta) {
      if (categoria != 'Todas' && planta.categorias != categoria) {
        return false;
      }
      final contenido = _normalizar(
        '${planta.nombre} ${planta.categorias} ${planta.palabrasClave.join(' ')}',
      );
      return palabras.every(contenido.contains);
    }).toList();
  }

  String _normalizar(String texto) {
    return texto
        .toLowerCase()
        .replaceAll(RegExp(r'[áàäâ]'), 'a')
        .replaceAll(RegExp(r'[éèëê]'), 'e')
        .replaceAll(RegExp(r'[íìïî]'), 'i')
        .replaceAll(RegExp(r'[óòöô]'), 'o')
        .replaceAll(RegExp(r'[úùüû]'), 'u')
        .trim();
  }
}
