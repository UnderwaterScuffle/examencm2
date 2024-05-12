import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({Key? key}) : super(key: key);

  @override
  _CategoriasScreenState createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  List<dynamic> categorias = [];

  @override
  void initState() {
    super.initState();
    listarCategorias();
  }

  Future<void> listarCategorias() async { ///// no funciona????
    final url = Uri.http('143.198.118.203:8050', '/ejemplos/category_list_rest/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        categorias = jsonResponse['categorias'];
      });
    } else {
      throw Exception('Failed to load categorias');
    }
  }

Future<void> editarCategoria(dynamic categoria) async {
  const String _baseUrl = "143.198.118.203:8050";
  const String _user = "test";
  const String _pass = "test2023";

  final url = Uri.http(_baseUrl, '/ejemplos/category_edit_rest/');
  
  // preparar datos para enviar post
  final Map<String, dynamic> requestBody = {
    'category_id': categoria['category_id'],
    'category_name': categoria['category_name'],
    'category_state': categoria['category_state'], 
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
      // editado correctamente
    } else {
      // error handle
      throw Exception('no se pudo editar');
    }
  } catch (e) {
    // error handle
    throw Exception('Error: $e');
  }
}

Future<void> eliminarCategoria(dynamic categoria) async {
  const String _baseUrl = "143.198.118.203:8050";
  const String _user = "test";
  const String _pass = "test2023";

  final url = Uri.http(_baseUrl, '/ejemplos/category_del_rest/');

  // preparar datos para post
  final Map<String, dynamic> requestBody = {
    'category_id': categoria['category_id'],
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
      // eliminado correctamente
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
        title: const Text('Categorías'),
      ),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final categoria = categorias[index];
          return ListTile(
            title: Text(categoria['category_name']),
            onTap: () {
              // ?
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Editar o eliminar categoría'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Editar'),
                        onTap: () {
                          Navigator.pop(context);
                          editarCategoria(categoria);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Eliminar'),
                        onTap: () {
                          Navigator.pop(context);
                          eliminarCategoria(categoria);
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