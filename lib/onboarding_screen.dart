import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_florist, size: 64, color: Colors.green),
              const SizedBox(height: 24),
              const Text(
                'Cultiva, aprende y crece',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 32, 118, 35)),
                  textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Vivero+ te ayuda a comprar plantas y llevar el cuidado de tu jardin en un solo lugar.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }, child: const Text('Comenzar')),
            ],
          ),
        ),
      ),
    );
  }
}
