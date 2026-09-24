import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';
import 'car_provider.dart';
import 'core_theme.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const ViveroApp(),
    ),
  );
}
class ViveroApp extends StatelessWidget {
  const ViveroApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vivero+',
      debugShowCheckedModeBanner: false,
      theme: buildViveroTheme(),
      home: const SplashScreen(),
    );
  }
}