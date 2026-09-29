import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String texto;
  final IconData? icono;
  final VoidCallback onPressed;

  const CustomButtom({
    super.key,
    required this.texto,
    required this.icono,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (icono != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icono),
        label: Text(texto),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(texto),
    );
  }
}
