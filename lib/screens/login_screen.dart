import 'dart:developer';

import 'package:daily_wellness/core/constants/constant.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void _login() {
  if (_formKey.currentState!.validate()) {
    log("Login successful! Navigating...");
    Navigator.pushNamed(context, '/dashboard');
  }
}
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 11, 11),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Image.asset(
                      'assets/images/health.png',
                      height: 70,
                      width: 70,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Column(
                          children: const [
                            Icon(Icons.error, color: Colors.red),
                            Text(
                              "Image not found",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    "DailyWellness",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Email Field
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: emailCtrl,
                      style: const TextStyle(color: Colors.white), // 👈 input text color
                      decoration: InputDecoration(
                        labelText: email,
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return emailRequired;
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return emailValidation;
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Password Field
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: passwordCtrl,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white), // 👈 input text color
                      decoration: InputDecoration(
                        labelText: password,
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent),
                        ),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? passwordRequired : null,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Login Button
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 231, 97, 189),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        login,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
