import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> event;

  const BookingScreen({super.key, required this.event});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool loading = false;
  String message = "";

  void bookEvent() async {
    setState(() => loading = true);

    try {
      // Simulate success
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        message = "Successfully booked: ${widget.event["title"]}";
        loading = false;
      });
    } catch (e) {
      setState(() {
        message = "Failed to book event";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Scaffold(
      appBar: AppBar(title: const Text("Book Event")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Booking for: ${event["title"]}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: bookEvent,
                    child: const Text("Confirm Booking"),
                  ),
                  const SizedBox(height: 20),
                  if (message.isNotEmpty)
                    Text(
                      message,
                      style: TextStyle(
                        color: message.startsWith("Failed") ? Colors.red : Colors.green,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
