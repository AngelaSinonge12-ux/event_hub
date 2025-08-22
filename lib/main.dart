import 'package:event_hub/screens/bookings_details.dart';
import 'package:event_hub/screens/landing_page.dart';
import 'package:event_hub/screens/login_screen.dart';
import 'package:event_hub/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'screens/events_screen.dart';
import 'screens/bookings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (context) => const BookingListScreen(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/events': (context) => const EventScreen(),
        // '/event-details': (context) => const EventDetailsScreen(),
        '/booking': (context) => const BookingListScreen(),
       // ignore: equal_keys_in_map
      // '/bookings_details': (context) => BookingConfirmationScreen(eventId: 1, availableSeats: 23, bookingId:1 ,),
      },
    );
  }
}
