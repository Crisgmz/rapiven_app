import 'package:flutter/material.dart';
import 'business_details_step2.dart';

class BusinessDetailsStep1 extends StatefulWidget {
  final String ownerName;
  final String email;
  final String dni;
  final String password;
  final String confirmPassword;

  const BusinessDetailsStep1({
    required this.ownerName,
    required this.email,
    required this.dni,
    required this.password,
    required this.confirmPassword,
    super.key,
  });

  @override
  State<BusinessDetailsStep1> createState() => _BusinessDetailsStep1State();
}

class _BusinessDetailsStep1State extends State<BusinessDetailsStep1> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _rncController = TextEditingController();
  bool _isRegistered = false;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF011f41);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Datos del Negocio - Paso 1'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo para el nombre del negocio
            TextField(
              controller: _businessNameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Negocio',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Pregunta sobre el RNC
            Text(
              '¿El negocio está registrado con un RNC?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Row(
              children: [
                // Opción "Sí"
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Sí'),
                    value: true,
                    groupValue: _isRegistered,
                    onChanged: (value) {
                      setState(() {
                        _isRegistered = value!;
                      });
                    },
                  ),
                ),
                // Opción "No"
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('No'),
                    value: false,
                    groupValue: _isRegistered,
                    onChanged: (value) {
                      setState(() {
                        _isRegistered = value!;
                        _rncController
                            .clear(); // Limpiar el campo RNC si no está registrado
                      });
                    },
                  ),
                ),
              ],
            ),
            // Campo de RNC (solo si está registrado)
            if (_isRegistered)
              TextField(
                controller: _rncController,
                decoration: InputDecoration(
                  labelText: 'Número de RNC',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2.5),
                  ),
                ),
              ),
            const SizedBox(height: 30),
            // Botón para continuar
            FilledButton(
              onPressed: _onContinuePressed,
              style: FilledButton.styleFrom(
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
    );
  }

  void _onContinuePressed() {
    // Validar el nombre del negocio
    if (_businessNameController.text.isEmpty) {
      _showError('Por favor, ingresa el nombre del negocio.');
      return;
    }

    // Validar el RNC si está registrado
    if (_isRegistered && _rncController.text.isEmpty) {
      _showError('Por favor, ingresa el número de RNC.');
      return;
    }

    // Navegar a la siguiente pantalla
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusinessDetailsStep2(
          ownerName: widget.ownerName,
          email: widget.email,
          dni: widget.dni,
          password: widget.password,
          businessName: _businessNameController.text,
          isRegistered: _isRegistered,
          rnc: _isRegistered ? _rncController.text : '',
          confirmPassword: widget.confirmPassword,
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
