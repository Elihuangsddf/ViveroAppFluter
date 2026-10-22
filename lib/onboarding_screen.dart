import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'auth_repository.dart';
import 'auth_screen.dart';
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
              Image.asset('ImgPlants/LogoSecundario.png', width: 200),
              const SizedBox(height: 24),
              const Text(
                'Cultiva, aprende y crece',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 32, 118, 35),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Explora nuestro catálogo, conoce los cuidados disponibles y agrega plantas a tu carrito.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  final Widget destino;
                  if (kIsWeb ||
                      defaultTargetPlatform == TargetPlatform.android) {
                    destino = AuthRepository().currentUser == null
                        ? const AuthScreen()
                        : const HomeScreen();
                  } else {
                    destino = const HomeScreen();
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => destino),
                  );
                },
                child: const Text('Comenzar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
