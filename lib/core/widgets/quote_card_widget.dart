import 'package:flutter/material.dart';
import 'package:daily_wellness/services/api/quote_service.dart';

class QuoteCardWidget extends StatefulWidget {
  const QuoteCardWidget({super.key});

  @override
  State<QuoteCardWidget> createState() => _QuoteCardWidgetState();
}

class _QuoteCardWidgetState extends State<QuoteCardWidget> {
  String quote = '';
  String author = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    final result = await QuoteService.fetchQuoteOfTheDay();
    setState(() {
      quote = result['quote']!;
      author = result['author']!;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
