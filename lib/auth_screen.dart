import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_repository.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthRepository _auth =AuthRepository();
  final TextEditingController _correoCtl = TextEditingController();
  final TextEditingController _contrasenaCtl = TextEditingController();

  bool esRegistro = false;
  bool cargando = false;
  String? error;

  @override
  void dispose() {
    _correoCtl.dispose();
    _contrasenaCtl.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    final correo = _correoCtl.text.trim();
    final contrasena = _contrasenaCtl.text.trim();
    if (correo.isEmpty || contrasena.isEmpty) {
      setState(() => error = 'Escribe tu correo y contraseña');
      return;
    }
    setState(() {
      cargando = true;
      error = null;
    });

    try{
      if (esRegistro) {
        await _auth.registrar(correo, contrasena);
      } else {
        await _auth.iniciarSesion(correo, contrasena);
      }
      if(!mounted) return;
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    }on FirebaseAuthException catch (e) {
      setState(() => error = AuthRepository.mensajeDeError(e));
    } finally {
      if(mounted) setState(() => cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(esRegistro ? 'Crear Cuenta' : 'Iniciar sesión'),
      ),
      body: Center(
        child:SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset('ImgPlants/LogoSecundario.png', width: 200, height: 200),
              SizedBox(height: 24),
              TextField(
                controller: _correoCtl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: _contrasenaCtl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              if(error != null) ...[
                const SizedBox(height: 12),
                Text(error!, style: TextStyle(color: Colors.red)),
              ],
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: cargando ? null : _enviar,
                child: cargando ? const SizedBox(
                  height:20,
                  width:20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
                : Text(esRegistro ? 'Registrarme' : 'Entrar'),
                )
              ),
              TextButton(
                onPressed: cargando 
                    ? null 
                    : () => setState(() => esRegistro = !esRegistro),
                
                child: Text(
                  esRegistro 
                  ? '¿Ya tienes cuenta? Inicia sesión' 
                  : '¿No tienes cuenta? Regístrate'
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
