import 'package:flutter/material.dart';
import 'package:rapiven_app/features/auth/screens/client_details_screen.dart';
import 'package:rapiven_app/features/auth/screens/business_personal_details_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF011f41);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título principal
              Text(
                '¿Eres Cliente o Restaurante?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 40),
              // Botón de Cliente
              RoleSelectionButton(
                label: 'Cliente',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClientDetailsScreen(),
                    ),
                  );
                },
                primaryColor: primaryColor,
              ),
              const SizedBox(height: 20),
              // Botón de Restaurante
              RoleSelectionButton(
                label: 'Restaurante',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonalDetailsScreen(role: 'Restaurante'),
                    ),
                  );
                },
                primaryColor: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Botón modular para Cliente y Restaurante
class RoleSelectionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color primaryColor;

  const RoleSelectionButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
