import 'package:flutter/material.dart';
import 'core_theme.dart';

class PlantCard extends StatelessWidget {
  final String nombre;
  final String precio;
  final String rutaImagen;
  final VoidCallback onTap;

  const PlantCard({
    super.key,
    required this.nombre,
    required this.precio,
    required this.rutaImagen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(aspectRatio: 1,
              child: Image.asset(
                rutaImagen,
                fit: BoxFit.cover,
              ),
            ),
            Padding(padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text(nombre, style:const TextStyle(fontWeight: .w600),),
                const SizedBox(height: 4,),
                Text(precio, style: const TextStyle(fontWeight: FontWeight.w400),),
              ],
            ),
            ),
          ],
        ),
      ),
    );
  }
}
