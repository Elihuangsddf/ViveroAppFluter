import 'package:flutter/material.dart';
import 'core_theme.dart';
import 'plant_card.dart';
import 'plant_model.dart';
import 'plant_details_screen.dart';
import 'plant_repository.dart';

// StatefulWidget permite actualizar el catálogo al escribir o elegir un filtro.
class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final PlantRepository _repository = PlantRepository();
  String categoriaSeleccionada = 'Todas';
  String textoBusqueda = '';

  List<Plant> get plantasFiltradas {
    return _repository.buscarPlantas(
      categoria: categoriaSeleccionada,
      texto: textoBusqueda,
    );
  }

  @override
  Widget build(BuildContext context) {
    final resultados = plantasFiltradas;
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Actualiza la búsqueda al escribir y vuelve a calcular los resultados.
            TextField(
              onChanged: (texto) => setState(() => textoBusqueda = texto),
              decoration: InputDecoration(
                hintText: 'Buscar plantas o palabras relacionadas',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Muestra las tres categorías debajo de la barra de búsqueda.
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                children: ['Todas', 'Interior', 'Exterior'].map((categoria) {
                  return ChoiceChip(
                    label: Text(categoria),
                    // Resalta la categoría activa y la cambia al tocar el chip.
                    selected: categoriaSeleccionada == categoria,
                    selectedColor: AppColors.primarioClaro,
                    onSelected: (_) =>
                        setState(() => categoriaSeleccionada = categoria),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              // Si no hay coincidencias, informa al usuario; si las hay, muestra la cuadrícula.
              child: resultados.isEmpty
                  ? const Center(child: Text('No se encontraron plantas'))
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final columnas = constraints.maxWidth < 600 ? 2 : 3;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columnas,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.78,
                              ),
                          // La cuadrícula usa únicamente las plantas filtradas.
                          itemCount: resultados.length,
                          itemBuilder: (context, index) {
                            final planta = resultados[index];
                            return Hero(
                              tag: planta.nombre,
                              child: PlantCard(
                                nombre: planta.nombre,
                                precio: planta.precio,
                                rutaImagen: planta.rutaImagen,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlantDetailsScreen(
                                        nombrePlanta: planta.nombre,
                                        rutaImagen: planta.rutaImagen,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
