import 'package:flutter/material.dart';

class PlantImage extends StatelessWidget {
  final String ruta;
  final double height;
  final BoxFit fit;
  const PlantImage({
    super.key,
    required this.ruta,
    this.height = 200,
    this.fit = BoxFit.cover,
  });
  bool get _esUrl {
    final uri = Uri.tryParse(ruta.trim());
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Widget _placeholder() {
    return Container(
      height: height,
      color: Colors.grey.shade100,
      alignment: Alignment.center,
      child: const Icon(Icons.local_florist, size: 40, color: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imagen = ruta.trim();
    if (imagen.isEmpty) return _placeholder();
    if (_esUrl) {
      return Image.network(
        imagen,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, progreso) {
          if (progreso == null) return child;
          return SizedBox(
            height: height,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }
    return Image.asset(
      imagen,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );
  }
}
