import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Registrar usuario en Firebase Authentication
  Future<User?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Error al registrar usuario: $e');
    }
  }

  // Guardar datos adicionales en Firestore
  Future<void> saveUserData({
    required String uid,
    required String role,
    required String email,
    required String name,
    required String businessName,
    required bool isRegistered,
    required String rnc,
    required String code,
    required String logoUrl,
    required Map<String, String> openingHours,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'role': role,
        'email': email,
        'name': name,
        'businessName': businessName,
        'isRegistered': isRegistered,
        'rnc': rnc,
        'status': 'active',
        'code': code,
        'logoUrl': logoUrl,
        'openingHours': openingHours,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error al guardar datos del usuario: $e');
    }
  }

  // Generar código único de 8 dígitos
  String generateUniqueCode() {
    final random = DateTime.now().millisecondsSinceEpoch % 100000000;
    return random.toString().padLeft(8, '0');
  }
}
