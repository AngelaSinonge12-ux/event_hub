 // ignore_for_file: library_private_types_in_public_api

 import 'package:event_hub/screens/bookings_screen.dart';
import 'package:event_hub/services/api_service.dart';
import 'package:flutter/material.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final int eventId;
  final int availableSeats;

  const BookingConfirmationScreen({
    super.key,
    required this.eventId,
    required this.availableSeats, required int bookingId,
  });

  @override
  _BookingConfirmationScreenState createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  int _selectedSeats = 1;
  bool _isLoading = false;
  Map<String, dynamic>? _eventDetails;

  @override
  void initState() {
    super.initState();
    _selectedSeats = widget.availableSeats > 0 ? 1 : 0;
    _fetchEventDetails();
  }

  Future<void> _fetchEventDetails() async {
    try {
      final event = await ApiService.getEventDetails(widget.eventId);
      setState(() {
        _eventDetails = event;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load event details: $e")),
        );
      }
    }
  }

  Future<void> _bookEvent() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ApiService.bookEvent(
        eventId: widget.eventId,
        seats: _selectedSeats,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking successful!')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BookingListScreen()),
          (Route<dynamic> route) => false, 
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _showConfirmationDialog() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Booking"),
        content: Text(
            "Are you sure you want to book $_selectedSeats seat(s) for ${_eventDetails?['title'] ?? 'this event'}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirm"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _bookEvent();
    }
  }

  @override
  Widget build(BuildContext context) {
    final noSeatsAvailable = widget.availableSeats <= 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Your Booking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_eventDetails != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _eventDetails?['title'] ?? "Event #${widget.eventId}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text("Date: ${_eventDetails?['date'] ?? 'N/A'}"),
                ],
              )
            else
              const Text("Loading event details..."),
            
            const SizedBox(height: 20),
            Text("Available Seats: ${widget.availableSeats}"),
            const SizedBox(height: 20),

            if (!noSeatsAvailable)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Number of Seats:"),
                  DropdownButton<int>(
                    value: _selectedSeats,
                    items: List.generate(widget.availableSeats, (index) => index + 1)
                        .map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSeats = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),
            
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: noSeatsAvailable ? null : _showConfirmationDialog,
                      child: Text(noSeatsAvailable ? "No Seats Available" : "Confirm and Pay"),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}