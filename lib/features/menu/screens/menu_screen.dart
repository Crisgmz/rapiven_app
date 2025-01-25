import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 31, 65),
        title: const Text('Menú'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMenuItem(context, 'Plato del Día', Icons.fastfood, () {
            // Acción para el Plato del Día
          }),
          _buildMenuItem(context, 'Bebidas', Icons.local_drink, () {
            // Acción para Bebidas
          }),
          _buildMenuItem(context, 'Postres', Icons.cake, () {
            // Acción para Postres
          }),
          _buildMenuItem(context, 'Entradas', Icons.restaurant_menu, () {
            // Acción para Entradas
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
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
