import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class AuthService {
  static Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse("${Config.apiBaseUrl}/register"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse("${Config.apiBaseUrl}/login"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);

    // Laravel usually returns "token" or "access_token"
    final token = data["token"] ?? data["access_token"];

    if (response.statusCode == 200 && token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);
    }

    return data;
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    await http.post(
      Uri.parse("${Config.apiBaseUrl}/logout"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    prefs.remove("token");
  }
}
