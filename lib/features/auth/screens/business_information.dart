import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BusinessDetailsScreen extends StatefulWidget {
  const BusinessDetailsScreen({super.key});

  @override
  State<BusinessDetailsScreen> createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _rncController = TextEditingController();
  bool _isRegistered = false; // Indica si tiene RNC o no
  String? _logoPath; // Ruta de la imagen seleccionada
  final Map<String, TimeOfDay> _openingHours = {}; // Horario por día
  final Map<String, TimeOfDay> _closingHours = {}; // Cierre por día

  // Días de la semana
  final List<String> _days = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo"
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF011f41);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Datos del Negocio',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _businessNameController,
              label: 'Nombre del Negocio',
              primaryColor: primaryColor,
            ),
            const SizedBox(height: 20),
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
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('No'),
                    value: false,
                    groupValue: _isRegistered,
                    onChanged: (value) {
                      setState(() {
                        _isRegistered = value!;
                        _rncController
                            .clear(); // Limpia el campo si no está registrado
                      });
                    },
                  ),
                ),
              ],
            ),
            if (_isRegistered)
              _buildTextField(
                controller: _rncController,
                label: 'Número de RNC',
                primaryColor: primaryColor,
              ),
            const SizedBox(height: 20),
            // Selector de horarios
            Text(
              'Horarios del Negocio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            _buildOpeningHours(primaryColor),
            const SizedBox(height: 20),
            // Subir logo
            Text(
              'Cargar Logo o Imagen del Negocio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            _buildLogoUploader(primaryColor),
            const SizedBox(height: 30),
            // Botón de continuar
            FilledButton(
              onPressed: () {
                // Aquí puedes implementar la lógica de guardar datos o avanzar
                Navigator.pop(context);
              },
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required Color primaryColor,
  }) {
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

  Widget _buildOpeningHours(Color primaryColor) {
    return Column(
      children: _days.map((day) {
        return Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(day, style: TextStyle(color: primaryColor)),
              ),
            ),
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
                _closingHours[day]?.format(context) ?? 'Cierre',
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Future<void> _selectTime(
      BuildContext context, String day, bool isOpening) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isOpening) {
          _openingHours[day] = pickedTime;
        } else {
          _closingHours[day] = pickedTime;
        }
      });
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
}
