import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'car_provider.dart';
import 'core_theme.dart';
import 'plant_model.dart';

class PlantDetailsScreen extends StatelessWidget {
  final String nombrePlanta;
  final String rutaImagen;

  const PlantDetailsScreen({
    super.key,
    required this.nombrePlanta,
    required this.rutaImagen,
  });

  static const Map<String, Map<String, String>> _cuidados = {
    'Monstera': {
      'descripcion': 'La Monstera destaca por sus hojas grandes y recortadas. Va bien en interiores con buena luz natural.',
      'luz': 'Luz indirecta, cerca de una ventana.',
      'riego': 'Riega cuando la capa superior de la tierra esté seca.',
    },
    'Ficus': {
      'descripcion': 'El Ficus lyrata tiene hojas grandes y firmes. Busca un lugar luminoso donde pueda quedarse a gusto.',
      'luz': 'Luz abundante, sin sol directo intenso.',
      'riego': 'Deja que la superficie de la tierra se seque entre riegos.',
    },
    'Sansevieria': {
      'descripcion': 'La Sansevieria crece erguida y necesita pocos cuidados. Es una buena opción para empezar.',
      'luz': 'Tolera poca luz; crece mejor con luz indirecta.',
      'riego': 'Riega poco y espera a que la tierra se seque.',
    },
    'Spathiphyllum': {
      'descripcion': 'El Spathiphyllum tiene hojas verdes y flores blancas. Prefiere un rincón luminoso, sin sol directo.',
      'luz': 'Luz indirecta.',
      'riego': 'Mantén la tierra ligeramente húmeda, sin encharcar.',
    },
    'Calathea': {
      'descripcion': 'La Calathea llama la atención por el dibujo de sus hojas. Se siente mejor en interiores protegidos del sol directo.',
      'luz': 'Luz indirecta y suave.',
      'riego': 'Procura que la tierra conserve algo de humedad, sin dejar agua en el plato.',
    },
  };

  @override
  Widget build(BuildContext context) {
    final planta = plantasDemo.firstWhere(
      (item) => item.nombre == nombrePlanta,
      orElse: () => Plant(
        nombre: nombrePlanta,
        precio: '',
        rutaImagen: rutaImagen,
        categorias: 'Interior',
      ),
    );
    final detalle = _cuidados[nombrePlanta] ?? const {
      'descripcion': 'Una planta para sumar un poco de verde a tu espacio.',
      'luz': 'Luz natural indirecta.',
      'riego': 'Riega cuando la tierra empiece a secarse.',
    };

    return Scaffold(
      appBar: AppBar(title: Text(nombrePlanta)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: nombrePlanta,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        rutaImagen,
                        height: 260,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        nombrePlanta,
                        style: const TextStyle(
                          color: AppColors.textoPrincipal,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (planta.precio.isNotEmpty)
                      Text(
                        planta.precio,
                        style: const TextStyle(
                          color: AppColors.primario,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  planta.categorias,
                  style: const TextStyle(color: AppColors.textoSecundario),
                ),
                const SizedBox(height: 16),
                Text(
                  detalle['descripcion']!,
                  style: const TextStyle(
                    color: AppColors.textoPrincipal,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 22),
                
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().agregarAlCarrito();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$nombrePlanta agregada al carrito')),
                      );
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Agregar al carrito'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CareRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  const _CareRow({required this.icon, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primario),
        const SizedBox(width: 10),
        SizedBox(
          width: 54,
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(
            detail,
            style: const TextStyle(color: AppColors.textoSecundario, height: 1.35),
          ),
        ),
      ],
    );
  }
}
