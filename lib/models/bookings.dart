import 'package:decimal/decimal.dart';

class Booking {
  final int id;
  final int userId;
  final int eventId;
  final Decimal totalAmount;
  final String status;
  Booking({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.totalAmount,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['user_id'],
      eventId: json['event_id'],
      totalAmount: Decimal.parse(json['totalAmount'].toString()),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'event_id': eventId,
      'total_amount': totalAmount.toString(),
      'status': status,
    };
  }
}
