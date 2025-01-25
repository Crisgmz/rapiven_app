import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapiven_app/features/auth/data/auth_service.dart';
import 'package:rapiven_app/features/home/screens/business_home_screen.dart';
import 'package:rapiven_app/features/home/screens/client_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;

  void _login() async {
    setState(() {
      _isLoading = true;
      _emailError = null;
      _passwordError = null;
    });

    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      // Validate email
      if (email.isEmpty) {
        _handleValidationError(
            'emailError', 'El correo electrónico es obligatorio.');
        return;
      }

      if (!_isValidEmailFormat(email)) {
        _handleValidationError(
            'emailError', 'El formato del correo no es válido.');
        return;
      }

      // Validate password
      if (password.isEmpty) {
        _handleValidationError(
            'passwordError', 'La contraseña es obligatoria.');
        return;
      }

      if (password.length < 8) {
        _handleValidationError(
            'passwordError', 'La contraseña debe tener al menos 8 caracteres.');
        return;
      }

      // Attempt login
      final user =
          await _authService.signInWithEmailAndPassword(email, password);

      if (user != null) {
        final role = await _authService.getUserRole(user.uid);
        _navigateBasedOnRole(role);
      }
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
    } catch (e) {
      _showGenericError(
          'Error al iniciar sesión, las credenciales no son correctas');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleValidationError(String errorType, String message) {
    setState(() {
      if (errorType == 'emailError') {
        _emailError = message;
      } else {
        _passwordError = message;
      }
      _isLoading = false;
    });
  }

  bool _isValidEmailFormat(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _navigateBasedOnRole(String role) {
    switch (role) {
      case 'business':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BusinessHomeScreen()),
        );
        break;
      case 'client':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ClientHomeScreen()),
        );
        break;
      default:
        _showGenericError('Rol no reconocido');
    }
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'No existe una cuenta con este correo.';
        setState(() => _emailError = errorMessage);
        break;
      case 'wrong-password':
        errorMessage = 'La contraseña es incorrecta.';
        setState(() => _passwordError = errorMessage);
        break;
      case 'invalid-credential':
        errorMessage = 'El formato de las credenciales es inválido.';
        setState(() => _emailError = errorMessage);
        break;
      default:
        errorMessage =
            'Error al iniciar sesión, las credenciales no son correctas';
    }
    _showGenericError(errorMessage);
  }

  void _showGenericError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

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
                'Iniciar Sesión',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  labelStyle: const TextStyle(color: primaryColor),
                  errorText: _emailError,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: primaryColor, width: 2.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2.5),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: primaryColor),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: primaryColor),
                  errorText: _passwordError,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: primaryColor, width: 2.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2.5),
                  ),
                ),
                obscureText: true,
                style: const TextStyle(color: primaryColor),
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton(
                      onPressed: _login,
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
                label: 'Continuar con Teléfono',
                icon: Icons.phone,
                onPressed: () {
                  // Implementación futura
                },
              ),
              const SizedBox(height: 10),
              // Botones de redes sociales
              _buildOutlinedButton(
                label: 'Continuar con Google',
                icon: FontAwesomeIcons.google,
                onPressed: () {
                  // Implementación futura
                },
              ),
              const SizedBox(height: 10),
              _buildOutlinedButton(
                label: 'Continuar con Facebook',
                icon: FontAwesomeIcons.facebook,
                onPressed: () {
                  // Implementación futura
                },
              ),
              const SizedBox(height: 10),
              _buildOutlinedButton(
                label: 'Continuar con Apple',
                icon: FontAwesomeIcons.apple,
                onPressed: () {
                  // Implementación futura
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    const primaryColor = Color(0xFF011f41);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Icon(icon, color: primaryColor),
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
