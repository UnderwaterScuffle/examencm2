import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'proveedores'); // Navegar proveedores
              },
              child: const Text('Proveedores'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'categorias'); // Navegar categorias
              },
              child: const Text('Categorías'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'productos'); // Navegar productos
              },
              child: const Text('Productos'),
            ),
          ],
        ),
      ),
    );
  }
}