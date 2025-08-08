import 'package:flutter/material.dart'; 
import 'package:decimal/decimal.dart'; 

class Event {
  final int id;
  final String title;
  final Text description;
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
      description: Text(json['description']),
      location: json['location'],
      totalSeats: json['total_seats'],
      price: Decimal.parse(json['price'].toString()),
      date: DateTime.parse(json['date']),
    );}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description.data,
      'location': location,
      'total_seats': totalSeats,
      'price': price.toString(),
      'date': date.toIso8601String(),
    };
  }
}
