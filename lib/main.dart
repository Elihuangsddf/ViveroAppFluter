import 'package:flutter/material.dart';
void main() {
  runApp(const ViveroApp());
}
class ViveroApp extends StatelessWidget {
  const ViveroApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vivero+',
      home:Scaffold(
        appBar: AppBar(
          title: const Text('Vivero+'),
          backgroundColor: Colors.green.shade400,
        ),
        body: Center(
          child: Padding(padding: 
          const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration:BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.eco,
                  size:64,
                  color: Color.fromARGB(255, 6, 102, 9),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Bienvenidos a Vivero+',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 32, 118, 35),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Cuida tus plantas, cultiva tu mente.',
                style: TextStyle(
                  fontSize:16,
                  color:Colors.grey 
                ),
              ),
              const SizedBox(height: 36),
              Row(
                children:[
                  Expanded(child: _StatCard(
                    icon: Icons.local_florist,
                    label:'3 por agregar',
                  ),),
                  const SizedBox(width:12),
                  Expanded(child: _StatCard(
                    icon: Icons.water_drop,
                    label:'3 por regar',
                  ),)
                ]
              )
            ],
          ))
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
        borderRadius: BorderRadius.circular(12),
      ),
      child:Column(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize:13)),
        ],
      )
    );
  }
}