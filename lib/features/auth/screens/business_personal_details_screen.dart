import 'package:flutter/material.dart';
import 'package:rapiven_app/features/auth/screens/business_details_step1.dart';

class PersonalDetailsScreen extends StatefulWidget {
  final String role; // Cliente o Restaurante

  const PersonalDetailsScreen({super.key, required this.role});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF011f41);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Datos Personales',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Nombre',
                primaryColor,
                controller: _firstNameController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Apellido',
                primaryColor,
                controller: _lastNameController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Correo Electrónico',
                primaryColor,
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Cédula o DNI',
                primaryColor,
                controller: _dniController,
              ),
              const SizedBox(height: 10),
              _buildPasswordField(
                'Contraseña',
                primaryColor,
                controller: _passwordController,
              ),
              const SizedBox(height: 10),
              _buildPasswordField(
                'Confirmar Contraseña',
                primaryColor,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 20),
              if (widget.role == 'Restaurante') // Solo si es un restaurante
                ElevatedButton(
                  onPressed: _navigateToBusinessDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Color primaryColor,
      {required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: primaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2.5),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, Color primaryColor,
      {required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: true, // Ocultar texto
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: primaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2.5),
        ),
      ),
    );
  }

  void _navigateToBusinessDetails() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _dniController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusinessDetailsStep1(
          ownerName: '${_firstNameController.text} ${_lastNameController.text}',
          email: _emailController.text,
          dni: _dniController.text,
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        ),
      ),
    );
  }
}
