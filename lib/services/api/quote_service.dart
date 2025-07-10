// lib/services/quote_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  static Future<Map<String, String>> fetchQuoteOfTheDay() async {
    try {
      final response = await http.get(Uri.parse('https://favqs.com/api/qotd'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'quote': data['quote']['body'] ?? 'No quote found',
          'author': data['quote']['author'] ?? 'Unknown',
        };
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      return {
        'quote': 'Failed to load quote',
        'author': '',
      };
    }
  }
}
