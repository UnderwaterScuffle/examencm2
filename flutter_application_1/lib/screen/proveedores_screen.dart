import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String _baseUrl = "143.198.118.203:8050";
final String _user = "test";
final String _pass = "test2023";

class ProveedoresScreen extends StatelessWidget { 
  const ProveedoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores'),
      ),
      body: ProveedoresList(),
    );
  }
}

class ProveedoresList extends StatelessWidget { // no funciona??
  const ProveedoresList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: proveedores.length,
      itemBuilder: (context, index) {
        final proveedor = proveedores[index];
        return ListTile(
          title: Text(proveedor['provider_name']),
          onTap: () {
            // ver detalles screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProveedorDetailsScreen(proveedor: proveedor),
              ),
            );
          },
        );
      },
    );
  }
}

class ProveedorDetailsScreen extends StatelessWidget {
  final dynamic proveedor;

  const ProveedorDetailsScreen({Key? key, required this.proveedor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proveedor Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre: ${proveedor['provider_name']}'),
            // otros detalles
          ],
        ),
      ),
    );
  }
}

Future<void> editarProveedor(dynamic proveedor) async {
  try {
    final url = Uri.http(_baseUrl, '/ejemplos/provider_edit_rest');
    final response = await http.post(
      url,
      body: jsonEncode({
        'provider_id': proveedor['provider_id'],
        'provider_name': proveedor['provider_name'],
        'provider_last_name': proveedor['provider_last_name'],
        'provider_mail': proveedor['provider_mail'],
        'provider_state': proveedor['provider_state'],
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Basic ${base64Encode(utf8.encode("$_user:$_pass"))}',
      },
    );

    if (response.statusCode == 200) {
      // editado
    } else {
      // Handle error
      throw Exception('no se pudo editar');
    }
  } catch (e) {
    // Handle exception
    print('Error: $e');
  }
}

Future<void> eliminarProveedor(dynamic proveedor) async {
  try {
    final url = Uri.http(_baseUrl, '/ejemplos/provider_del_rest');
    final response = await http.post(
      url,
      body: jsonEncode({'provider_id': proveedor['provider_id']}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Basic ${base64Encode(utf8.encode("$_user:$_pass"))}',
      },
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

// data dummy
final List<Map<String, dynamic>> proveedores = [
  {
    'provider_id': 1,
    'provider_name': 'Proveedor 1',
  },
  {
    'provider_id': 2,
    'provider_name': 'Proveedor 2',
  },
];