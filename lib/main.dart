import 'package:flutter/material.dart';
import 'splash_screen.dart';
void main() {
  runApp(const ViveroApp());
}
class ViveroApp extends StatelessWidget {
  const ViveroApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vivero+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green,useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}