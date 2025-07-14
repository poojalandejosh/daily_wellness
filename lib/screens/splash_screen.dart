import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final isLoggedIn = snapshot.data ?? false;
          Future.microtask(() {
            Navigator.pushReplacementNamed(
              context,
              isLoggedIn ? '/dashboard' : '/login',
            );
          });
          return const SizedBox(); // empty while redirecting
        }
      },
    );
  }
}
