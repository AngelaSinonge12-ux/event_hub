// lib/utils/constants.dart

class ApiConstants {
  // Base URL of your Laravel backend
  // For Android Emulator use 10.0.2.2 instead of localhost
  // For real device, replace with your machine's IP address (e.g. http://192.168.x.x:8000/api)
  static const String baseUrl = "http://10.0.2.2:8000/api";

  // Endpoints
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String events = "$baseUrl/events";
  static const String bookings = "$baseUrl/bookings";
}