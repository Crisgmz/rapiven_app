import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 31, 65),
        title: const Text('Configuración'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingsItem(context, 'Perfil', Icons.person, () {
            // Acción para Perfil
          }),
          _buildSettingsItem(context, 'Notificaciones', Icons.notifications,
              () {
            // Acción para Notificaciones
          }),
          _buildSettingsItem(context, 'Idioma', Icons.language, () {
            // Acción para Idioma
          }),
          _buildSettingsItem(context, 'Privacidad', Icons.lock, () {
            // Acción para Privacidad
          }),
          _buildSettingsItem(context, 'Cerrar Sesión', Icons.logout, () {
            // Acción para Cerrar Sesión
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sesión cerrada')),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Color.fromARGB(255, 1, 31, 65)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 1, 31, 65),
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
