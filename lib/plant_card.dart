import 'package:flutter/material.dart';

import 'core_theme.dart';
import 'plant_model.dart';

class PlantCard extends StatelessWidget {
  final Plant planta;
  final VoidCallback onTap;

  const PlantCard({super.key, required this.planta, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primario.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox.expand(
                  child: _PlantImage(path: planta.rutaImagen, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              planta.nombre,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textoPrincipal,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              planta.precioTexto,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.primario,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlantImage extends StatelessWidget {
  const _PlantImage({required this.path, this.fit});

  final String path;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(path);
    final isNetworkImage = uri != null &&
        (uri.scheme == 'https' || uri.scheme == 'http');
    return Image(
      image: isNetworkImage ? NetworkImage(path) : AssetImage(path),
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.green.shade50,
        alignment: Alignment.center,
        child: const Icon(Icons.local_florist, size: 44, color: Colors.green),
      ),
    );
  }
}
