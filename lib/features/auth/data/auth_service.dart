import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Inicia sesión con correo y contraseña
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      print('Intentando iniciar sesión con email: $email');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Inicio de sesión exitoso para UID: ${userCredential.user?.uid}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Manejo específico de errores de FirebaseAuth
      if (e.code == 'user-not-found') {
        print('No existe un usuario con el email proporcionado.');
        throw Exception('No existe una cuenta con ese correo.');
      } else if (e.code == 'wrong-password') {
        print('La contraseña ingresada es incorrecta.');
        throw Exception('Contraseña incorrecta.');
      } else if (e.code == 'invalid-email') {
        print('El formato del correo electrónico es inválido.');
        throw Exception('El correo electrónico no es válido.');
      } else {
        print('Error inesperado en FirebaseAuth: ${e.message}');
        throw Exception('Error al iniciar sesión: ${e.message}');
      }
    } catch (e) {
      // Manejo genérico de errores
      print('Error general al iniciar sesión: $e');
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  /// Obtiene el rol del usuario desde Firestore
  Future<String> getUserRole(String firebaseAuthUid) async {
    try {
      print('Obteniendo documento del usuario con UID: $firebaseAuthUid');
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(firebaseAuthUid).get();

      if (userDoc.exists) {
        print('Documento del usuario obtenido: ${userDoc.data()}');
        final data = userDoc.data() as Map<String, dynamic>;

        if (data.containsKey('role')) {
          final role = data['role'] as String;
          print('Rol del usuario obtenido: $role');
          return role;
        } else {
          print('El documento no contiene el campo "role".');
          throw Exception('El usuario no tiene un rol asignado.');
        }
      } else {
        print('El documento del usuario no existe en Firestore.');
        throw Exception('El usuario no existe en la base de datos.');
      }
    } on FirebaseException catch (e) {
      // Manejo específico de errores de Firebase
      print('Error de Firebase al obtener el rol del usuario: ${e.message}');
      throw Exception('Error al obtener el rol del usuario: ${e.message}');
    } catch (e) {
      // Manejo genérico de errores
      print('Error al obtener el rol del usuario: $e');
      throw Exception('Error al obtener el rol del usuario: $e');
    }
  }
}
