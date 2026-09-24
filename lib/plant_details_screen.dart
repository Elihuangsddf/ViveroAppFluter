import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'car_provider.dart';

class PlantDetailsScreen extends StatelessWidget{
  final String nombrePlanta;
  const PlantDetailsScreen({super.key, required this.nombrePlanta});
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text(nombrePlanta)),
      body: Center(
        child: Padding(padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_florist, size: 80,color: Colors.green),
            SizedBox(height: 16),
            Text(
              nombrePlanta,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: (){
              context.read<CartProvider>().agregarAlCarrito();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$nombrePlanta agregada al carrito'),),
                );
            },
            icon: const Icon(Icons.add_shopping_cart), 
            label: const Text('Agregar al Carrito'))
          ],
        ),
        ),
      ),
    );
  }
}
