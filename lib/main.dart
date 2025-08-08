import 'package:event_hub/screens/bookings_screen.dart';
import 'package:event_hub/screens/events_screen.dart';
import 'package:event_hub/screens/landing_page.dart';
import 'package:event_hub/screens/login_screen.dart';
import 'package:event_hub/screens/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Booking App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //routes
      initialRoute: '/',
      routes: {
        '/': (context) => LandingScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/events': (context) => EventScreen(),
        '/booking': (context) => BookingScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
