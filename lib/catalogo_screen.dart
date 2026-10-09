import 'package:flutter/material.dart';
import 'plant_card.dart';
import 'plant_model.dart';
import 'plant_details_screen.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columnas = constraints.maxWidth < 600 ? 2 : 3;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnas,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.78,
            ),
            itemCount: plantasDemo.length,
            itemBuilder: (context, index) {
              final planta = plantasDemo[index];
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
    );
  }
}
