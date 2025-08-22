import 'package:flutter/material.dart';

class Helpers {
  static void showSnackBar(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? Colors.black87,
      ),
    );
  }

  static String formatDate(String date) {
    try {
      DateTime dt = DateTime.parse(date);
      return "${dt.day}/${dt.month}/${dt.year}";
    } catch (e) {
      return date;
    }
  }
}
