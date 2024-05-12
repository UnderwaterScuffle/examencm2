import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({Key? key}) : super(key: key);

  @override
  _ProductosScreenState createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  List<dynamic> productos = [];

  @override
  void initState() {
    super.initState();
    listarProductos();
  }

  Future<void> listarProductos() async { // no funciona??
    final url = Uri.http('143.198.118.203:8050', '/ejemplos/product_list_rest/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        productos = jsonResponse['productos'];
      });
    } else {
      throw Exception('Failed to load productos');
    }
  }

  Future<void> editarProducto(dynamic producto) async {
    const String _baseUrl = "143.198.118.203:8050";
    const String _user = "test";
    const String _pass = "test2023";

    final url = Uri.http(_baseUrl, '/ejemplos/product_edit_rest/');

    // preparar post
    final Map<String, dynamic> requestBody = {
      'product_id': producto['product_id'],
      'product_name': producto['product_name'],
      'product_price': producto['product_price'],
      'product_image': producto['product_image'],
      'product_state': producto['product_state'],
    };

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // editado.
      } else {
        // error handle
        throw Exception('Failed to edit');
      }
    } catch (e) {
      // error handle
      throw Exception('Error: $e');
    }
  }

  Future<void> eliminarProducto(dynamic producto) async {
    const String _baseUrl = "143.198.118.203:8050";
    const String _user = "test";
    const String _pass = "test2023";

    final url = Uri.http(_baseUrl, '/ejemplos/product_del_rest/');

    // preparar para post
    final Map<String, dynamic> requestBody = {
      'product_id': producto['product_id'],
    };

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // eliminado.
      } else {
        // error handle
        throw Exception('no se pudo eliminar');
      }
    } catch (e) {
      // error handle
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return ListTile(
            title: Text(producto['product_name']),
            onTap: () {
              // mostrar detalles
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Editar o eliminar producto'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Editar'),
                        onTap: () {
                          Navigator.pop(context);
                          editarProducto(producto);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Eliminar'),
                        onTap: () {
                          Navigator.pop(context);
                          eliminarProducto(producto);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}