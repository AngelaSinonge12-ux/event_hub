import 'package:event_hub/screens/bookings_details.dart';
import 'package:event_hub/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:event_hub/models/bookings.dart'; 

class BookingListScreen extends StatefulWidget {


  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  late Future<List<Booking>> _futureBookings;

  @override
  void initState() {
    super.initState();
    _futureBookings = ApiService.getBookings();
  }

  Future<void> _refreshBookings() async {
    setState(() {
      _futureBookings = ApiService.getBookings();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Bookings refreshed")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshBookings,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshBookings,
        child: FutureBuilder<List<Booking>>(
          future: _futureBookings,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No bookings found."));
            }

            final bookings = snapshot.data!;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.confirmation_number, color: Colors.blue),
                    title: Text(
                      "Booking #${booking.id}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Event ID: ${booking.eventId}\n"
                      "Amount: \$${booking.totalAmount}"
                      "Status: ${booking.status}",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingConfirmationScreen(
                           eventId: booking.eventId,
                            availableSeats: booking.availableSeats,
                             bookingId: booking.id),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
