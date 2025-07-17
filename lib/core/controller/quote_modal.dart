class Quote {
  final String quote;
  final String author;

  Quote({required this.quote, required this.author});

  factory Quote.fromJson(Map<String, dynamic> data) {
    return Quote(
      quote: data['quote']['body'] ?? 'No quote found',
      author: data['quote']['author'] ?? 'Unknown',
    );
  }
}
