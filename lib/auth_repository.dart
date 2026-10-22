import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  Stream<User?> get cambiosDeSesion => _auth.authStateChanges();
  Future<void> registrar(String correo, String contrasena) async {
    await _auth.createUserWithEmailAndPassword(
      email: correo,
      password: contrasena,
    );
  }

  Future<void> iniciarSesion(String correo, String contrasena) async {
    await _auth.signInWithEmailAndPassword(email: correo, password: contrasena);
  }

  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }

  static String mensajeDeError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Este correo ya tiene una cuenta.';
      case 'invalid-email':
        return 'El correo electrónico que ingresaste no es válido.';
      case 'weak-password':
        return 'La contraseña es muy debil, debe tener al menos 6 caracteres.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'network-request-failed':
        return 'No hay conexión a internet.';
      default:
        return 'Ocurrió un error inesperado. Por favor, inténtalo de nuevo.';
    }
  }
}
