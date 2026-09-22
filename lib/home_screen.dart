import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'car_provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool esFavorito = false;
  void alternativoFavorito() {
    setState(() {
      esFavorito = !esFavorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
          title: const Text(
            'Vivero+',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
        ),
        actions:[Padding(padding: const EdgeInsets.only(right: 16),
        child:Center(
          child:Text(
          '🛒${context.watch<CartProvider>().cantidad}',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        ),
        )],
        backgroundColor: Colors.green.shade400,

      ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.eco,
                        size: 100,
                        color: Color.fromARGB(255, 6, 102, 9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Bienvenido a ViveroMax',
                  style: TextStyle(fontSize: 26, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 21, 161, 25)),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cuida tus plantas, cultiva tu mente',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                ElevatedButton.icon(
                  onPressed: alternativoFavorito, 
                  icon: Icon(
                    esFavorito ? Icons.favorite : Icons.favorite_border,
                    color: esFavorito ? Colors.red : null,
                  ), 
                  label: Text(
                    esFavorito ? 'En favoritos' : 'Agregar a favoritos'
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: (){
                    context.read<CartProvider>().agregarAlCarrito();
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Agregar al Carrito')
                  ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        icon: Icons.local_florist,
                        label: '12 Plantas',
                      )
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatCard(
                        icon: Icons.water_drop,
                        label: '3 por regar',
                      ),
                    ),
                  ],
                ),
              ],
              ),
            ),
          ),
        );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const StatCard({required this.icon, required this.label});

  @override
  Widget build(Object context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Color.fromARGB(255, 6, 102, 9)),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(
            fontSize: 13,
            color: Color.fromARGB(255, 6, 102, 9),
            fontWeight: FontWeight.w300,
          )),
        ]
      )
    );
  }
}