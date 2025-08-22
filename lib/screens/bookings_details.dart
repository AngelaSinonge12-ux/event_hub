import 'package:event_hub/models/bookings.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final ApiService apiService = ApiService();
  List<Booking> bookings = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  void fetchBookings() async {
    try {
      List<Booking> fetchedBookings = await apiService.fetchBookings(1); // Hardcoded userId=1
      setState(() {
        bookings = fetchedBookings;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : bookings.isEmpty
              ? const Center(child: Text("No bookings found"))
              : ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    // Booking booking = bookings[index];
                    return ListTile(
                      leading: const Icon(Icons.event),
                      // title: Text(Booking.title),
                      // subtitle: Text("Date: ${booking.date}"),
                    );
                  },
                ),
    );
  }
}
