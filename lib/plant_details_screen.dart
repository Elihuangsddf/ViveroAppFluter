import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'car_provider.dart';

class PlantDetailsScreen extends StatelessWidget {
  static const Color _verdeDetalle = Color(0xFF087A4A);

  final String plantaId;
  final String nombrePlanta;
  final String rutaImagen;
  final String? precio;
  final String? categoria;

  const PlantDetailsScreen({
    super.key,
    required this.plantaId,
    required this.nombrePlanta,
    required this.rutaImagen,
    this.precio,
    this.categoria,
  });

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<CartProvider>();
    final cantidad = carrito.cantidadDe(plantaId);
    final uri = Uri.tryParse(rutaImagen);
    final esImagenRemota =
        uri != null && (uri.scheme == 'https' || uri.scheme == 'http');

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF5),
      appBar: AppBar(title: Text(nombrePlanta)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ColoredBox(
                        color: Colors.white,
                        child: Image(
                          image: esImagenRemota
                              ? NetworkImage(rutaImagen)
                              : AssetImage(rutaImagen),
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 64,
                                  color: _verdeDetalle,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 28,
                    ),
                    decoration: BoxDecoration(
                      color: _verdeDetalle,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      children: [
                        Text(
                          nombrePlanta,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (precio != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            precio!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        if (categoria != null) ...[
                          const SizedBox(height: 14),
                          Text(
                            'Categoría de la planta: $categoria',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().agregarAlCarrito(plantaId);
                      _aviso(context, '$nombrePlanta agregada al carrito');
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Agregar al carrito'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(58),
                      foregroundColor: _verdeDetalle,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: _verdeDetalle, width: 1.5),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  if (cantidad > 0) ...[
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: () {
                        context.read<CartProvider>().eliminarDelCarrito(
                          plantaId,
                        );
                        _aviso(context, '$nombrePlanta quitada del carrito');
                      },
                      icon: const Icon(Icons.remove_shopping_cart_outlined),
                      label: const Text('Quitar del carrito'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _aviso(BuildContext context, String mensaje) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(SnackBar(content: Text(mensaje)));
  }
}
