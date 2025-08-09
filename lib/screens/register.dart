import 'package:event_hub/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'login_controller.dart';
import 'screens.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
          'assets/images/register.png', 
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
                    color: Colors.white,
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
                  CustomTextField(
                    hint: "Phone",
                    controller: loginController.phoneController,
                  ),
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
                  color:Colors.indigo,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Register",
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
                  MaterialPageRoute(
                    builder: (context) => const Login(), 
                  ),
                );
              },
              child: RichText(
                text: const TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
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
