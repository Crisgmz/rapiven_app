import 'package:flutter/material.dart';
import 'package:rapiven_app/features/menu/screens/menu_screen.dart';
import 'package:rapiven_app/features/settings/screens/settings_screen.dart';

class BusinessHomeScreen extends StatefulWidget {
  const BusinessHomeScreen({super.key});

  @override
  State<BusinessHomeScreen> createState() => _BusinessHomeScreenState();
}

class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    BusinessHomeContent(), // Pantalla principal del negocio
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
              'Rapiven - Negocio',
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

class BusinessHomeContent extends StatelessWidget {
  const BusinessHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Saludos, Cristian (Negocio)',
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
                    'Total de Ganancias al Día de Hoy',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\$12,253.70',
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
                _buildGridItem(context, 'Nueva Venta', Icons.point_of_sale,
                    Colors.blue, '/pos'),
                _buildGridItem(context, 'Cocina', Icons.kitchen, Colors.orange,
                    '/kitchen'),
                _buildGridItem(context, 'Facturación', Icons.receipt,
                    Colors.purple, '/billing'),
                _buildGridItem(context, 'Reportes', Icons.analytics,
                    Colors.cyan, '/reports'),
                _buildGridItem(
                    context,
                    'Transacciones',
                    Icons.account_balance_wallet,
                    Colors.indigo,
                    '/transactions'),
                _buildGridItem(context, 'Repartidor', Icons.delivery_dining,
                    Colors.red, '/delivery'),
                _buildGridItem(context, 'Mesas', Icons.table_chart,
                    Colors.yellow, '/tables'),
                _buildGridItem(context, 'Pedidos', Icons.shopping_cart,
                    Colors.green, '/orders'),
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
