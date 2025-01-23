import 'package:flutter/material.dart';
import 'package:rapiven_app/features/auth/screens/login_screen.dart';
import 'package:rapiven_app/features/auth/screens/role_selection_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapiven App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RoleSelectionScreen(),
      },
    );
  }
}
