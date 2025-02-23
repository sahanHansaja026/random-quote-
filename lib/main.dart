import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

@immutable
class Quote {
  final String text;
  final String author;
  final String category;
  final String details;
  final String imagePath;

  const Quote({
    required this.text,
    required this.author,
    required this.category,
    required this.details,
    required this.imagePath,
  });
}

final List<Quote> quotes = [
  Quote(
    text: "Be the change you wish to see in the world.",
    author: "Mahatma Gandhi",
    category: "Inspirational",
    details:
        "This famous quote emphasizes the importance of personal responsibility in creating social change. Gandhi believed true change starts from within.",
    imagePath: "assets/gandhi.jpg",
  ),
  Quote(
    text: "The only way to do great work is to love what you do.",
    author: "Steve Jobs",
    category: "Career",
    details:
        "From his 2005 Stanford commencement address, Jobs emphasized passion as key to professional success.",
    imagePath: "assets/jobs.jpg",
  ),
];

final List<String> categories = ["Inspirational", "Career", "Life", "Wisdom"];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const QuoteScreen(),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late String selectedCategory;
  late Quote currentQuote;

  @override
  void initState() {
    super.initState();
    selectedCategory = categories.first;
    currentQuote = _getRandomQuote(selectedCategory);
  }

  Quote _getRandomQuote(String category) {
    final filteredQuotes = quotes.where((q) => q.category == category).toList();
    return filteredQuotes.isEmpty
        ? quotes.first
        : filteredQuotes[Random().nextInt(filteredQuotes.length)];
  }

  void _updateCategory(String? newCategory) {
    if (newCategory != null) {
      setState(() {
        selectedCategory = newCategory;
        currentQuote = _getRandomQuote(newCategory);
      });
    }
  }

  void _getNewQuote() {
    setState(() {
      currentQuote = _getRandomQuote(selectedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 59, 251),
        title: const Text(
          'Daily Quote',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          DropdownMenu<String>(
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all(Colors.deepPurple[50]),
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              elevation: WidgetStateProperty.all(8),
              shadowColor:
                  WidgetStateProperty.all(Colors.purple.withOpacity(0.1)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.deepPurple),
                ),
              ),
            ),
            initialSelection: categories.first,
            onSelected: _updateCategory,
            dropdownMenuEntries: categories.map((String category) {
              return DropdownMenuEntry<String>(
                value: category,
                label: category,
                style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(
                        color: Color.fromARGB(255, 237, 237, 237),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QuoteDetailScreen(quote: currentQuote),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        currentQuote.text,
                        style: const TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '- ${currentQuote.author}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getNewQuote,
              child: const Text('New Quote'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuoteDetailScreen extends StatelessWidget {
  final Quote quote;

  const QuoteDetailScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About ${quote.author}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (quote.imagePath.isNotEmpty)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(quote.imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            const SizedBox(height: 20),
            Text(
              quote.author,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              quote.details,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
