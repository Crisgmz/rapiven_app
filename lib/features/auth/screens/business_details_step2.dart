import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class BusinessDetailsStep2 extends StatefulWidget {
  final String ownerName;
  final String email;
  final String dni;
  final String password; // Contraseña para Firebase Authentication
  final String confirmPassword; // Confirmación de contraseña
  final String businessName;
  final bool isRegistered;
  final String rnc;

  const BusinessDetailsStep2({
    required this.ownerName,
    required this.email,
    required this.dni,
    required this.password,
    required this.confirmPassword,
    required this.businessName,
    required this.isRegistered,
    required this.rnc,
    super.key,
  });

  @override
  State<BusinessDetailsStep2> createState() => _BusinessDetailsStep2State();
}

class _BusinessDetailsStep2State extends State<BusinessDetailsStep2> {
  final Map<String, TimeOfDay> _openingHours = {};
  String? _logoPath;

  final List<String> _days = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo",
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF011f41);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Datos del Negocio - Paso 2'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Horarios
            ..._days.map((day) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(day, style: TextStyle(color: primaryColor)),
                  TextButton(
                    onPressed: () => _selectTime(context, day, true),
                    child: Text(
                      _openingHours[day]?.format(context) ?? 'Apertura',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectTime(context, day, false),
                    child: Text(
                      _openingHours[day]?.format(context) ?? 'Cierre',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 30),
            // Logo
            Text(
              'Cargar Logo del Negocio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            _buildLogoUploader(primaryColor),
            const SizedBox(height: 30),
            // Botón para guardar
            FilledButton(
              onPressed: _saveBusinessDetails,
              style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Finalizar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveBusinessDetails() async {
    // Validar logo cargado
    if (_logoPath == null) {
      _showError('Por favor, carga un logo.');
      return;
    }

    // Validar contraseña
    if (widget.password != widget.confirmPassword) {
      _showError('Las contraseñas no coinciden.');
      return;
    }

    if (widget.password.length < 8) {
      _showError('La contraseña debe tener al menos 8 caracteres.');
      return;
    }

    try {
      // Obtener instancias de Firebase
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Generar IDs únicos para usuario y negocio
      final String userId = const Uuid().v4(); // ID del usuario
      final String businessId = const Uuid().v4(); // ID del negocio

      // Registrar usuario en Firebase Authentication
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password, // Contraseña proporcionada
      );

      final String firebaseAuthUid = userCredential.user!.uid;

      // Subir logo al Storage
      final String logoUrl = await _uploadLogo(businessId);

      // Formatear horarios
      final Map<String, String> formattedHours = _openingHours.map((day, time) {
        return MapEntry(day, time.format(context));
      });

      // Guardar datos del usuario en la colección "users"
      await firestore.collection('users').doc(firebaseAuthUid).set({
        'uid':
            firebaseAuthUid, // Este debe ser el mismo UID generado por Firebase Auth
        'ownerName': widget.ownerName,
        'email': widget.email,
        'dni': widget.dni,
        'role': 'business',
        'businessId': businessId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Guardar datos del negocio en la colección "businesses"
      await firestore.collection('businesses').doc(businessId).set({
        'businessId': businessId,
        'ownerUserId': userId, // ID del usuario asociado
        'businessName': widget.businessName,
        'rnc': widget.rnc,
        'isRegistered': widget.isRegistered,
        'logoUrl': logoUrl,
        'openingHours': formattedHours,
        'status': 'pending', // Estado inicial del negocio
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Negocio registrado exitosamente.')),
      );

      Navigator.pop(context);
    } catch (e) {
      _showError('Error: $e');
    }
  }

  Future<String> _uploadLogo(String businessId) async {
    final storageRef = FirebaseStorage.instance.ref();
    final fileRef = storageRef.child('logos/$businessId.png');
    final file = File(_logoPath!);

    final uploadTask = fileRef.putFile(file);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> _selectTime(
      BuildContext context, String day, bool isOpening) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime.minute % 30 == 0) {
      setState(() {
        _openingHours[day] = pickedTime;
      });
    } else {
      _showError('Selecciona un intervalo de 30 minutos.');
    }
  }

  Widget _buildLogoUploader(Color primaryColor) {
    return Column(
      children: [
        _logoPath == null
            ? const Icon(Icons.image, size: 50, color: Colors.grey)
            : Image.file(
                File(_logoPath!),
                height: 100,
              ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: _pickLogo,
          icon: const Icon(Icons.upload_file),
          label: const Text('Subir Imagen'),
        ),
      ],
    );
  }

  Future<void> _pickLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _logoPath = image.path;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
