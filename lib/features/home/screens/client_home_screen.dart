import 'package:flutter/material.dart';
import 'package:rapiven_app/features/menu/screens/menu_screen.dart';
import 'package:rapiven_app/features/settings/screens/settings_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    ClientHomeContent(), // Pantalla principal del cliente
    MenuScreen(), // Pantalla del Menú
    SettingsScreen(), // Pantalla de Configuración
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 31, 65),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rapiven - Cliente',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Configuración') {
                  setState(() {
                    _currentIndex = 2; // Cambia a Configuración
                  });
                } else if (value == 'Cerrar Sesión') {
                  // Lógica para cerrar sesión
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sesión cerrada')),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'Configuración',
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 10),
                        Text('Configuración'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Cerrar Sesión',
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 10),
                        Text('Cerrar Sesión'),
                      ],
                    ),
                  ),
                ];
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menú',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}

class ClientHomeContent extends StatelessWidget {
  const ClientHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Bienvenido, Cristian (Cliente)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Total de Pedidos Completados',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '15',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildGridItem(context, 'Nuevo Pedido', Icons.shopping_cart,
                    Colors.blue, '/new-order'),
                _buildGridItem(context, 'Historial', Icons.history,
                    Colors.orange, '/order-history'),
                _buildGridItem(context, 'Promociones', Icons.local_offer,
                    Colors.purple, '/promotions'),
                _buildGridItem(context, 'Soporte', Icons.support_agent,
                    Colors.cyan, '/support'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, IconData icon,
      Color color, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 5,
        color: color.withOpacity(0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
