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
          child: Text('Bienvenido a Vivero+',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade700,
          ),
          ),
          ),
      ),
      );
  }
}