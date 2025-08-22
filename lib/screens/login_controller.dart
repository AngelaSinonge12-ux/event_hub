import 'dart:convert';
import 'package:flutter/material.dart';
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
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      print("Attempting login for $email");

      final response = await http.post(
        Uri.parse("${Config.apiBaseUrl}/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print("Login response status: ${response.statusCode}");
      print("Login response body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data.containsKey("token")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["token"]);

        return {"success": true, "data": data};
      } else {
        return {
          "success": false,
          "message": data["message"] ?? "Login failed. Please try again.",
        };
      }
    } catch (e) {
      print("Login error: $e");
      return {"success": false, "message": "An unexpected error occurred."};
    }
  }

  // REGISTER
  Future<Map<String, dynamic>> handleRegister() async {
    try {
      final String name = nameController.text.trim();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      print("Attempting registration for $email");

      final response = await http.post(
        Uri.parse("${Config.apiBaseUrl}/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      print("Register response status: ${response.statusCode}");
      print("Register response body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data.containsKey("user")) {
        return {"success": true, "data": data};
      } else {
        return {
          "success": false,
          "message": data["message"] ?? "Registration failed. Please try again.",
        };
      }
    } catch (e) {
      print("Register error: $e");
      return {"success": false, "message": "An unexpected error occurred."};
    }
  }
}
