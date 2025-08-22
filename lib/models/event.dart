// import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class Event {
  final int id;
  final String title;
  final String description; // ✅ Changed from Text to String
  final String location;
  final int totalSeats;
  final Decimal price;
  final DateTime date;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.totalSeats,
    required this.price,
    required this.date,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '', // ✅ Safe null handling
      location: json['location'],
      totalSeats: json['total_seats'],
      price: Decimal.parse(json['price'].toString()),
      date: DateTime.parse(json['date']),
    );
  }

  // ✅ This is the map you can pass to BookingScreen
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'totalSeats': totalSeats,
      'price': price.toString(),
      'date': date.toIso8601String(),
      'image':
          'https://picsum.photos/200/300?random=$id', // optional placeholder
    };
  }
}
