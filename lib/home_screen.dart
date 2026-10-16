import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'car_provider.dart';
import 'catalogo_screen.dart';
import 'plant_details_screen.dart';
import 'plant_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _plantaDestacada = 'Monstera';
  bool esFavorito = false;

  void alternarFavorito() {
    setState(() => esFavorito = !esFavorito);
  }

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<CartProvider>();
    final totalPlantas = PlantRepository().obtenerPlantas().length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vivero+'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '🛒${carrito.cantidad}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  Image.asset(
                    'ImgPlants/logoPrincipal.png',
                    width: 220,
                    height: 220,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Bienvenido a Vivero+',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 21, 161, 25),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Explora plantas para tu espacio',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CatalogoScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.store),
                    label: const Text('Ver catálogo'),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.local_florist,
                          label: '$totalPlantas plantas en catálogo',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.shopping_cart,
                          label: '${carrito.cantidad} en carrito',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Planta destacada: Monstera',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ElevatedButton.icon(
                        onPressed: alternarFavorito,
                        icon: Icon(
                          esFavorito ? Icons.favorite : Icons.favorite_border,
                          color: esFavorito ? Colors.red : null,
                        ),
                        label: Text(
                          esFavorito ? 'Monstera favorita' : 'Guardar Monstera',
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => context
                            .read<CartProvider>()
                            .agregarAlCarrito(_plantaDestacada),
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Agregar Monstera'),
                      ),
                      ElevatedButton.icon(
                        onPressed: carrito.cantidadDe(_plantaDestacada) == 0
                            ? null
                            : () => context
                                  .read<CartProvider>()
                                  .eliminarDelCarrito(_plantaDestacada),
                        icon: const Icon(Icons.remove_shopping_cart),
                        label: const Text('Quitar Monstera'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlantDetailsScreen(
                          nombrePlanta: _plantaDestacada,
                          rutaImagen: 'ImgPlants/01-monstera-deliciosa.png',
                        ),
                      ),
                    ),
                    child: const Text('Ver detalles de Monstera'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const StatCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 6, 102, 9)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color.fromARGB(255, 6, 102, 9),
            ),
          ),
        ],
      ),
    );
  }
}
