import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  List<Plant> _plantas = [];
  bool _cargando = true;
  String? error;

  String categoriaSeleccionada = 'Todas';
  String textoBusqueda = '';

  // Combina la categoría elegida con el texto escrito en el buscador.
  List<Plant> get plantasFiltradas {
    final texto = textoBusqueda.trim().toLowerCase();
    return _plantas.where((planta) {
      final coincideCategoria =
          categoriaSeleccionada == 'Todas' ||
          planta.categoria.toLowerCase() ==
              categoriaSeleccionada.toLowerCase();
      final coincideTexto =
          texto.isEmpty ||
          planta.nombre.toLowerCase().contains(texto) ||
          planta.categoria.toLowerCase().contains(texto) ||
          planta.palabrasClave.any((palabra) => palabra.toLowerCase().contains(texto));
      return coincideCategoria && coincideTexto;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _cargarPlantas();
  }

  Future<void> _cargarPlantas() async {
    setState(() {
      _cargando = true;
      error = null;
    });

    try {
      final plantas = await _repository.obtenerPlantas();
      if (!mounted) return;
      setState(() {
        _plantas = plantas;
        _cargando = false;
      });
    } on FirebaseException catch (e) {
      final haySesion = FirebaseAuth.instance.currentUser != null;
      final proyecto = Firebase.app().options.projectId;
      debugPrint(
        'Firestore $proyecto/plantas: ${e.code}: ${e.message}; '
        'sesión activa: $haySesion',
      );
      if (!mounted) return;
      setState(() {
        _cargando = false;
        error = switch (e.code) {
          'permission-denied' when !haySesion =>
            'No hay una sesión activa en la app. Inicia sesión para consultar las plantas.',
          'permission-denied' =>
            'Firestore rechazó la lectura de plantas en $proyecto. '
                'Comprueba que la regla publicada permita leer /plantas.',
          'unavailable' =>
            'No se pudo conectar con Firestore. Revisa tu conexión.',
          _ => 'No se pudo cargar el catálogo (Firestore: ${e.code}).',
        };
      });
    } catch (e, stackTrace) {
      debugPrint('Error al cargar el catálogo: $e\n$stackTrace');
      if (!mounted) return;
      setState(() {
        _cargando = false;
        error = 'Error al cargar el catálogo. Intenta nuevamente.';
      });
    }
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
            Expanded(child: _contenido(resultados)),
          ],
        ),
      ),
    );
  }

  Widget _contenido(List<Plant> resultados) {
    // Mientras llegan los datos desde Firestore mostramos un indicador.
    if (_cargando) {
      return const Center(child: CircularProgressIndicator());
    }

    // Si la carga falló, permitimos reintentarla.
    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(error!, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            ElevatedButton.icon(
              onPressed: _cargarPlantas,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    // Si no hay coincidencias, informa al usuario; si las hay, muestra la cuadrícula.
    if (resultados.isEmpty) {
      return Center(
        child: Text(
          _plantas.isEmpty
              ? 'No hay documentos en la colección plantas del proyecto Firebase configurado.'
              : 'No se encontraron plantas',
          textAlign: TextAlign.center,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final columnas = constraints.maxWidth < 600 ? 2 : 3;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              tag: planta.id,
              child: PlantCard(
                planta: planta,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlantDetailsScreen(
                        plantaId: planta.id,
                        nombrePlanta: planta.nombre,
                        rutaImagen: planta.rutaImagen,
                        precio: planta.precioTexto,
                        categoria: planta.categoria,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
