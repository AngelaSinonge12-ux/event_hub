import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top image
              Image.asset('assets/images/landing.png', height: 250),

              SizedBox(height: 30),
              Text(
                'Discover Events That move you!',
                style: TextStyle(
                  fontSize: 20,
                  height: 1.5,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // App introduction paragraph
              Text(
                'From Concerts to Conferences-Find,Book and Enjoy events that match your vibe',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40),

              // "Get Started" button (Goes  to Register)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),

              SizedBox(height: 20),

              // Already have an account? Log in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
