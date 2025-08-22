import 'dart:convert';
import 'package:event_hub/models/bookings.dart';
import 'package:http/http.dart' as http;
import '../models/event.dart';
// import '../models/booking.dart';
import '../utils/constants.dart';

class ApiService {
  final String baseUrl = ApiConstants.baseUrl;

  // Get all events
  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/events'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception("Failed to load events");
    }
  }

  // Get event details
  Future<Event> fetchEventDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/events/$id'));

    if (response.statusCode == 200) {
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load event details");
    }
  }

  // Book an event
  Future<Booking> bookEvent(int eventId, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookings'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"event_id": eventId, "user_id": userId}),
    );

    if (response.statusCode == 201) {
      return Booking.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to book event");
    }
  }

  // Fetch user bookings
  Future<List<Booking>> fetchBookings(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/bookings'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((b) => Booking.fromJson(b)).toList();
    } else {
      throw Exception("Failed to load bookings");
    }
  }
}
