class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? dni; // Cedula o DNI
  final String? role; // Cliente o Restaurante

  // Datos del negocio
  final String? businessName;
  final String? rnc; // Número de RNC
  final bool isRegistered; // Indicador si está registrado o no
  final Map<String, String>? openingHours; // Ej: {"Lunes": "08:00-18:00"}
  final String? logoUrl; // URL o path de la foto del negocio

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.dni,
    this.role,
    this.businessName,
    this.rnc,
    required this.isRegistered,
    this.openingHours,
    this.logoUrl,
  });
}
