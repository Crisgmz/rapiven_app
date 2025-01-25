import 'package:flutter/material.dart';

class ClientDetailsScreen extends StatefulWidget {
  const ClientDetailsScreen({super.key});

  @override
  State<ClientDetailsScreen> createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _addAddress = false; // Flag para mostrar/ocultar la dirección

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF011f41);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () {
            Navigator.pop(context); // Volver a la pantalla anterior
          },
        ),
        title: const Text(
          'Registro Cliente',
          style: TextStyle(color: primaryColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Campos obligatorios
            _buildTextField(
              controller: _nameController,
              label: 'Nombre',
              primaryColor: primaryColor,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _emailController,
              label: 'Correo Electrónico',
              primaryColor: primaryColor,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _phoneController,
              label: 'Teléfono',
              primaryColor: primaryColor,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _passwordController,
              label: 'Contraseña',
              primaryColor: primaryColor,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            // Opción para agregar dirección
            _buildAddressSection(primaryColor),
            const SizedBox(height: 30),
            // Botón de registro
            FilledButton(
              onPressed: () {
                // Lógica de registro
                _registerClient();
              },
              style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Registrar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required Color primaryColor,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
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

  Widget _buildAddressSection(Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              _addAddress =
                  !_addAddress; // Mostrar/ocultar el campo de dirección
            });
          },
          child: Text(
            _addAddress ? 'Saltar Dirección' : 'Agregar Dirección',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (_addAddress)
          _buildTextField(
            controller: _addressController,
            label: 'Dirección',
            primaryColor: primaryColor,
          ),
      ],
    );
  }

  void _registerClient() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    final address = _addAddress ? _addressController.text.trim() : null;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      // Mostrar un mensaje de error si faltan campos obligatorios
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Por favor, completa todos los campos obligatorios.')),
      );
      return;
    }

    // Aquí puedes procesar el registro
    debugPrint('Registrando cliente:');
    debugPrint('Nombre: $name');
    debugPrint('Correo: $email');
    debugPrint('Teléfono: $phone');
    debugPrint('Contraseña: $password');
    debugPrint('Dirección: ${address ?? "No agregada"}');

    // Simulación de redirección al dashboard u otra pantalla
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cliente registrado exitosamente.')),
    );
    Navigator.pop(context);
  }
}
