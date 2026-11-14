class Plant {
  final String id;
  final String nombre;
  final double precio;
  /// Puede ser una ruta incluida en assets o una URL (por ejemplo Storage).
  final String rutaImagen;
  final String categoria;
  final String descripcion;
  final String luz;
  final String riego;
  final List<String> palabrasClave;

  const Plant({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.rutaImagen,
    required this.categoria,
    this.descripcion = '',
    this.luz = '',
    this.riego = '',
    this.palabrasClave = const [],
  });

  String get precioTexto => '\$${precio.toStringAsFixed(2)}';

  factory Plant.fromMap(String id, Map<String, dynamic> data) {
    String stringValue(List<String> keys, [String fallback = '']) {
      for (final key in keys) {
        final value = data[key];
        if (value is String && value.trim().isNotEmpty) return value.trim();
      }
      return fallback;
    }

    double numberValue(List<String> keys) {
      for (final key in keys) {
        final value = data[key];
        if (value is num) return value.toDouble();
        if (value is String) {
          final parsed = double.tryParse(value.replaceAll(',', '.'));
          if (parsed != null) return parsed;
        }
      }
      return 0;
    }

    final keywords = data['palabrasClave'] ?? data['keywords'];
    return Plant(
      id: id,
      nombre: stringValue(['nombre', 'name', 'nombrePlanta'], 'Nombre desconocido'),
      precio: numberValue(['precio', 'price']),
      rutaImagen: stringValue(['rutaImagen', 'imagenUrl', 'imageUrl', 'imagen']),
      categoria: stringValue(['categoria', 'category'], 'Sin categoría'),
      descripcion: stringValue(['descripcion', 'description']),
      luz: stringValue(['luz', 'light']),
      riego: stringValue(['riego', 'watering']),
      palabrasClave: keywords is List
          ? keywords.whereType<String>().toList(growable: false)
          : const [],
    );
  }
}
