import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class LoginController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // LOGIN
  Future<Map<String, dynamic>> handleLogin() async {
    try {
      final response = await http.post(
        Uri.parse("${Config.apiBaseUrl}/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data.containsKey("token")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["token"]);
      }

      print("Login API response: $data");
      return data;
    } catch (e) {
      print("Login error: $e");
      return {"error": "Something went wrong. Check API or network."};
    }
  }

  // REGISTER
  Future<Map<String, dynamic>> handleRegister() async {
    try {
      final response = await http.post(
        Uri.parse("${Config.apiBaseUrl}/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);
      print("Register API response: $data");
      return data;
    } catch (e) {
      print("Register error: $e");
      return {"error": "Something went wrong. Check API or network."};
    }
  }
}
