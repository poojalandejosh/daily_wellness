import 'package:flutter/material.dart';

class LandscapeHeaderSection extends StatelessWidget {
  final String userName;
  final String currentTime;
  final String quote;
  final String author;
  final bool isLoading;

  const LandscapeHeaderSection({
    super.key,
    required this.userName,
    required this.currentTime,
    required this.quote,
    required this.author,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Daily Wellness",
            style: const TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 111, 94, 94),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          "Welcome $userName 👋",
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          "Current Time: $currentTime",
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 16),
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
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quote,
                      style: const TextStyle(
                        fontFamily: 'Caveat',
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "- $author",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
