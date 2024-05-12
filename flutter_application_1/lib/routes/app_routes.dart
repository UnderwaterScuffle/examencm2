import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, WidgetBuilder> routes = {
    'login': (context) => const LoginScreen(),
    'home': (context) => const HomeScreen(),
    'list': (context) => const ListProductScreen(),
    'edit': (context) => const EditProductScreen(),
    'add_user': (context) => const RegisterUserScreen(),
    'categorias': (context) => const CategoriasScreen(), 
    'productos': (context) => const ProductosScreen(), 
    'proveedores': (context) => const ProveedoresScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}