import 'package:event_hub/screens/bookings_screen.dart';
import 'package:flutter/material.dart';
// import 'booking_screen.dart';

class EventsScreen extends StatefulWidget {
  final String email;
  const EventsScreen({super.key, required this.email});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> events = [
    {
      "title": "Tech Conference",
      "date": "2025-09-12",
      "image":
          "https://images.unsplash.com/photo-1506157786151-b8491531f063?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bXVzaWMlMjBmZXN0aXZhbHxlbnwwfHwwfHx8MA%3D%3D",
    },
    {
      "title": "Music Festival",
      "date": "2025-09-15",
      "image":
          "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fG11c2ljJTIwZmVzdGl2YWx8ZW58MHx8MHx8fDA%3D",
    },
    {
      "title": "Startup Meetup",
      "date": "2025-09-20",
      "image": "https://picsum.photos/200/300?random=3",
    },
    {
      "title": "Art Expo",
      "date": "2025-09-25",
      "image": "https://picsum.photos/200/300?random=4",
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Navigate to Profile Page")));
    } else if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Navigate to Bookings Page")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello, ${widget.email}!"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Available Events",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.network(
                            event["image"],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            event["title"],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text("Date: ${event["date"]}"),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookingScreen(event: event),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                          ),
                          child: const Text(
                            "Buy Ticket",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Bookings"),
        ],
        selectedItemColor: Colors.indigo,
      ),
    );
  }
}
