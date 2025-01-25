class UserModel {
  final String? firstName; // Nombre del usuario
  final String? lastName; // Apellido del usuario
  final String? email; // Correo electrónico
  final String? status;
  final String? password; // Contraseña
  final String? confirmPassword; // Contraseña

  final String? dni; // Cédula o DNI
  final String? role; // Cliente o Restaurante

  // Datos del negocio (solo para Restaurante)
  final String? businessName; // Nombre del negocio
  final String? rnc; // Número de RNC
  final bool isRegistered; // Indicador si está registrado con RNC o no
  final Map<String, String>? openingHours; // Ej: {"Lunes": "08:00-18:00"}
  final String? logoUrl; // URL del logo del negocio

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.status,
    this.dni,
    this.role,
    this.businessName,
    this.rnc,
    required this.isRegistered,
    this.openingHours,
    this.logoUrl,
  });

  // Serialización a Map (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'status': status,
      'dni': dni,
      'role': role,
      'businessName': businessName,
      'rnc': rnc,
      'isRegistered': isRegistered,
      'openingHours': openingHours,
      'logoUrl': logoUrl,
      'createdAt': DateTime.now().toIso8601String(), // Marca de tiempo
    };
  }

  // Deserialización desde Map (para recuperar de Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
      confirmPassword: map['confirmPassword'],
      status: map['status'],
      dni: map['dni'],
      role: map['role'],
      businessName: map['businessName'],
      rnc: map['rnc'],
      isRegistered: map['isRegistered'] ?? false,
      openingHours: map['openingHours'] != null
          ? Map<String, String>.from(map['openingHours'])
          : null,
      logoUrl: map['logoUrl'],
    );
  }
}
