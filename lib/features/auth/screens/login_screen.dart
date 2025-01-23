import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF011f41);

    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      resizeToAvoidBottomInset:
          true, // Ajusta el contenido cuando el teclado se abre
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título
              Text(
                'Iniciar Sesión',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 40),
              // Correo electrónico
              TextField(
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  labelStyle: const TextStyle(color: primaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: primaryColor, width: 2.5),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: primaryColor),
              ),
              const SizedBox(height: 20),
              // Contraseña
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: primaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: primaryColor, width: 2.5),
                  ),
                ),
                obscureText: true,
                style: const TextStyle(color: primaryColor),
              ),
              const SizedBox(height: 30),
              // Botón de iniciar sesión
              FilledButton(
                onPressed: () {
                  // Lógica de inicio de sesión
                },
                style: FilledButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              // Texto de registro debajo del botón principal
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  '¿No tienes cuenta? Regístrate aquí',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Línea divisoria
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('O'),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),
              // Botón de iniciar sesión con teléfono
              _buildOutlinedButton(
                label: 'Iniciar Sesión con Teléfono',
                icon: Icons.phone,
                onPressed: () {
                  // Lógica de inicio de sesión con Teléfono
                },
              ),
              const SizedBox(height: 10),
              // Botones de redes sociales
              _buildOutlinedButton(
                label: 'Continuar con Google',
                icon: FontAwesomeIcons.google, // Ícono de Google
                onPressed: () {
                  // Lógica de inicio de sesión con Google
                },
              ),
              const SizedBox(height: 10),
              _buildOutlinedButton(
                label: 'Continuar con Facebook',
                icon: FontAwesomeIcons.facebook, // Ícono de Facebook
                onPressed: () {
                  // Lógica de inicio de sesión con Facebook
                },
              ),
              const SizedBox(height: 10),
              _buildOutlinedButton(
                label: 'Continuar con Apple',
                icon: FontAwesomeIcons.apple, // Ícono de Apple
                onPressed: () {
                  // Lógica de inicio de sesión con Apple
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para construir botones personalizados estilo outlined
  Widget _buildOutlinedButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    const primaryColor = Color(0xFF011f41);
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: primaryColor),
      label: Text(
        label,
        style:
            const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}
