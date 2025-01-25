import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rapiven_app/features/auth/screens/login_screen.dart';
import 'package:rapiven_app/features/auth/screens/role_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicialización de Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapiven App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RoleSelectionScreen(),
      },
    );
  }
}
