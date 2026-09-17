import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vivero',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('vivero'),
          backgroundColor: Colors.green.shade400,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(
                    Icons.eco,
                    size: 64,
                    color: Color.fromARGB(255, 6, 102, 9),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Bienvenidos a vivero+',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 23, 162, 25),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'cuida tus plantas, cultiva tu mente ',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.local_florist,
                        label: '22 plantas',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
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
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(height: 8),
          Text(label, 
          style: TextStyle(
            fontSize: 13, 
            color: Colors.green,
            fontWeight: FontWeight.w100)),
        ],
      ),
    );
  }
}