
// ignore_for_file: use_build_context_synchronously
import 'package:event_hub/screens/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:event_hub/screens/register_screen.dart';
import 'screens.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/login.png',
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomTextField(
                    hint: "Full Name",
                    controller: loginController.fullNameController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: "Email",
                    controller: loginController.emailController,
                  ),
                  const SizedBox(height: 16),
                 
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: "Password",
                    controller: loginController.passwordController,
                    obscure: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: loginController.handleLogin,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              child: RichText(
                text: const TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  children: [
                    TextSpan(
                      text: "Register",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
