import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/api_service.dart';
import 'bookings_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final int eventId;

  const EventDetailsScreen({super.key, required this.eventId});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final ApiService apiService = ApiService();
  late Event event;
  bool loading = true;
  bool eventLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  void fetchEvent() async {
    try {
      Event fetchedEvent = await apiService.fetchEventDetails(widget.eventId);
      setState(() {
        event = fetchedEvent;
        loading = false;
        eventLoaded = true;
      });
    } catch (e) {
      setState(() {
        loading = false;
        eventLoaded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Event Details")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : !eventLoaded
              ? const Center(child: Text("Event not found"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Date: ${event.date}"),
                      Text("Location: ${event.location}"),
                      const SizedBox(height: 20),

                      // ✅ Only show description if it's not null and not empty
                      if (event.description.isNotEmpty)
                        Text(event.description),

                      const Spacer(),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  BookingScreen(event: event.toMap()),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                        ),
                        child: const Text("Book Now"),
                      ),
                    ],
                  ),
                ),
    );
  }
}
