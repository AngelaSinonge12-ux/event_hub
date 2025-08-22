import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:event_hub/models/bookings.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Config {
  static const String apiBaseUrl = "http://10.0.2.2:8000/api"; 
}

class ApiService {
  // Get saved auth token Melodies
  static Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  // Get all bookings
  static Future<List<Booking>> getBookings() async {
    final token = await _getToken();
    if (token == null) throw Exception("Authentication token not found.");

    try {
      final response = await http.get(
        Uri.parse("${Config.apiBaseUrl}/bookings"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List data = decoded is List ? decoded : decoded['data'] ?? [];
        return data.map((json) => Booking.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to load bookings (status: ${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  // Get booking details by id
  static Future<Booking> getBookingDetails(int bookingId) async {
    final token = await _getToken();
    if (token == null) throw Exception("Authentication token not found.");

    try {
      final response = await http.get(
        Uri.parse("${Config.apiBaseUrl}/bookings/$bookingId"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Booking.fromJson(data);
      } else {
        throw Exception(
            "Failed to load booking details (status: ${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  // Book an event
  static Future<Booking> bookEvent({
    required int eventId,
    required int seats,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception("Authentication token not found.");

    try {
      final response = await http.post(
        Uri.parse("${Config.apiBaseUrl}/bookings"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "event_id": eventId,
          "seats": seats,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Booking.fromJson(data);
      } else {
        throw Exception("Failed to book event: ${response.body}");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }

  /// Get event details
  static Future<Map<String, dynamic>> getEventDetails(int eventId) async {
    final token = await _getToken();
    if (token == null) throw Exception("Authentication token not found.");

    try {
      final response = await http.get(
        Uri.parse("${Config.apiBaseUrl}/events/$eventId"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception(
            "Failed to fetch event details (status: ${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}