import 'package:flutter/material.dart';
import 'core_theme.dart';
import 'plant_card.dart';
import 'plant_model.dart';
import 'plant_details_screen.dart';

// StatefulWidget permite actualizar el catálogo al escribir o elegir un filtro.
class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  // Guarda el texto de búsqueda y la categoría que está seleccionada.
  String busqueda = '';
  String categoriaSeleccionada = 'Todas';

  // Pasa el texto a minúsculas y elimina acentos para comparar sin distinguirlos.
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

  @override
  Widget build(BuildContext context) {
    // Separa la búsqueda en palabras e ignora los espacios vacíos.
    final palabrasBuscadas = _normalizar(
      busqueda,
    ).split(RegExp(r'\s+')).where((palabra) => palabra.isNotEmpty);

    // where conserva solo las plantas que cumplen la categoría y la búsqueda.
    final plantasFiltradas = plantasDemo.where((planta) {
      // "Todas" permite cualquier categoría; las demás deben coincidir.
      final coincideCategoria =
          categoriaSeleccionada == 'Todas' ||
          planta.categorias == categoriaSeleccionada;
      // Busca tanto en el nombre como en la categoría y las palabras relacionadas.
      final textoPlanta = _normalizar(
        '${planta.nombre} ${planta.categorias} ${planta.palabrasClave.join(' ')}',
      );
      // Cada palabra escrita debe aparecer en el texto de la planta.
      final coincideBusqueda = palabrasBuscadas.every(textoPlanta.contains);
      return coincideCategoria && coincideBusqueda;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Actualiza la búsqueda al escribir y vuelve a calcular los resultados.
            TextField(
              onChanged: (texto) => setState(() => busqueda = texto),
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
              child: plantasFiltradas.isEmpty
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
                          itemCount: plantasFiltradas.length,
                          itemBuilder: (context, index) {
                            final planta = plantasFiltradas[index];
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
