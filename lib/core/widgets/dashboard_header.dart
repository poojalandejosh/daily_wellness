import 'package:flutter/material.dart';
import 'package:daily_wellness/core/constants/constant.dart';

class DashboardHeader extends StatelessWidget {
  final String userName;
  final String currentTime;
  final bool isLoading;
  final Widget quoteCard;

  const DashboardHeader({
    super.key,
    required this.userName,
    required this.currentTime,
    required this.isLoading,
    required this.quoteCard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
        Center(
          child: Text(
            dailyWellness,
            style: const TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 111, 94, 94),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          "$welcome $userName 👋",
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Current Time: $currentTime",
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 16),
        

        // Quote Card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(26, 17, 17, 17),
            borderRadius: BorderRadius.circular(8),
          ),
          child: isLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                )
              : quoteCard,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
