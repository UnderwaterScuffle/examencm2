import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8050'; // APIEXAMEN.TXT

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.parse('http://$_baseUrl/accounts/login');
    final response = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    if (decodeResponse.containsKey('idToken')) {
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }

  Future<String?> create_user(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.parse('http://$_baseUrl/accounts/signup/');
    final response = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodeResponse = json.decode(response.body);
    if (decodeResponse.containsKey('idToken')) {
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }
}