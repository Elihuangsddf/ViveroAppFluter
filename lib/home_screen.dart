import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_repository.dart';
import 'auth_screen.dart';
import 'car_provider.dart';
import 'catalogo_screen.dart';
import 'plant_details_screen.dart';
import 'plant_model.dart';
import 'plant_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Plant>> _plantasFuture;
  bool esFavorito = false;

  @override
  void initState() {
    super.initState();
    _plantasFuture = PlantRepository().obtenerPlantas();
  }

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vivero+'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final navigator = Navigator.of(context);
              await AuthRepository().cerrarSesion();
              if (!mounted) return;
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthScreen()),
                (_) => false,
              );
            },
          ),
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
                  Image.asset('ImgPlants/logoPrincipal.png', width: 220, height: 220),
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
                    'Cuida tus plantas, cultiva tu mente',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AuthRepository().currentUser?.email ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CatalogoScreen()),
                    ),
                    icon: const Icon(Icons.store),
                    label: const Text('Ver catálogo'),
                  ),
                  const SizedBox(height: 24),
                  FutureBuilder<List<Plant>>(
                    future: _plantasFuture,
                    builder: (context, snapshot) {
                      final plantas = snapshot.data ?? const <Plant>[];
                      Plant? destacada;
                      for (final planta in plantas) {
                        if (planta.nombre.toLowerCase().contains('monstera')) {
                          destacada = planta;
                          break;
                        }
                      }
                      final plantaDestacada = destacada;

                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: StatCard(
                                  icon: Icons.local_florist,
                                  label: snapshot.hasError
                                      ? 'Catálogo no disponible'
                                      : snapshot.connectionState == ConnectionState.done
                                          ? '${plantas.length} plantas en catálogo'
                                          : 'Cargando catálogo…',
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
                          if (plantaDestacada != null) ...[
                            Text(
                              'Planta destacada: ${plantaDestacada.nombre}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () => setState(
                                    () => esFavorito = !esFavorito,
                                  ),
                                  icon: Icon(
                                    esFavorito ? Icons.favorite : Icons.favorite_border,
                                    color: esFavorito ? Colors.red : null,
                                  ),
                                  label: Text(esFavorito
                                      ? '${plantaDestacada.nombre} favorita'
                                      : 'Guardar ${plantaDestacada.nombre}'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () => context
                                      .read<CartProvider>()
                                      .agregarAlCarrito(plantaDestacada.id),
                                  icon: const Icon(Icons.add_shopping_cart),
                                  label: Text('Agregar ${plantaDestacada.nombre}'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: carrito.cantidadDe(plantaDestacada.id) == 0
                                      ? null
                                      : () => context
                                          .read<CartProvider>()
                                          .eliminarDelCarrito(plantaDestacada.id),
                                  icon: const Icon(Icons.remove_shopping_cart),
                                  label: Text('Quitar ${plantaDestacada.nombre}'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PlantDetailsScreen(
                                    plantaId: plantaDestacada.id,
                                    nombrePlanta: plantaDestacada.nombre,
                                    rutaImagen: plantaDestacada.rutaImagen,
                                    precio: plantaDestacada.precioTexto,
                                    categoria: plantaDestacada.categoria,
                                  ),
                                ),
                              ),
                              child: Text('Ver detalles de ${plantaDestacada.nombre}'),
                            ),
                          ] else if (snapshot.connectionState == ConnectionState.done &&
                              !snapshot.hasError)
                            const Text('No hay una Monstera en el catálogo.'),
                          if (snapshot.hasError)
                            const Text('No se pudo cargar el catálogo.'),
                        ],
                      );
                    },
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
