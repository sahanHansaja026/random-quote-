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
  Quote(
    text:
        "People will forget what you said, people will forget what you did, but people will never forget how you made them feel.",
    author: "Maya Angelou",
    category: "Inspirational",
    details:
        "From Angelou's memoir, highlighting the lasting impact of emotional connections in human interactions.",
    imagePath: "assets/angelou.jpg",
  ),
  Quote(
    text: "It always seems impossible until it's done.",
    author: "Nelson Mandela",
    category: "Inspirational",
    details:
        "Often cited in discussions about perseverance during South Africa's anti-apartheid struggle.",
    imagePath: "assets/mandela.jpg",
  ),
  Quote(
    text: "You become what you believe.",
    author: "Oprah Winfrey",
    category: "Career",
    details:
        "From Winfrey's leadership speeches, emphasizing the power of self-belief in professional growth.",
    imagePath: "assets/oprah.jpg",
  ),
  Quote(
    text: "Life is what happens when you're busy making other plans.",
    author: "John Lennon",
    category: "Life",
    details:
        "Popularized in Lennon's song 'Beautiful Boy', reflecting on life's unpredictability.",
    imagePath: "assets/lennon.jpg",
  ),
  Quote(
    text:
        "In the end, it's not the years in your life that count. It's the life in your years.",
    author: "Abraham Lincoln",
    category: "Life",
    details:
        "Often attributed to Lincoln, emphasizing quality over quantity of experiences.",
    imagePath: "assets/lincoln.jpg",
  ),
  Quote(
    text: "The only true wisdom is in knowing you know nothing.",
    author: "Socrates",
    category: "Wisdom",
    details:
        "Foundational concept in Socratic philosophy, demonstrating humility in knowledge.",
    imagePath: "assets/socrates.jpg",
  ),
  Quote(
    text: "It does not matter how slowly you go as long as you do not stop.",
    author: "Confucius",
    category: "Wisdom",
    details:
        "From the Analects of Confucius, advocating persistent progress over speed.",
    imagePath: "assets/confucius.jpg",
  ),
  Quote(
    text: "Imagination is more important than knowledge.",
    author: "Albert Einstein",
    category: "Wisdom",
    details:
        "From a 1929 interview, highlighting Einstein's view on creative thinking in problem-solving.",
    imagePath: "assets/einstein.jpg",
  ),
];

final List<String> categories = ["Inspirational", "Career", "Life", "Wisdom"];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug label
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
        backgroundColor: const Color(0xFF013BFB), // Deep blue for a modern look
        elevation: 4, // Adds subtle shadow
        title: const Text(
          'Daily Quote',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background for dropdown
                borderRadius: BorderRadius.circular(10), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownMenu<String>(
                initialSelection: categories.first,
                onSelected: _updateCategory,
                dropdownMenuEntries: categories.map((String category) {
                  return DropdownMenuEntry<String>(
                    value: category,
                    label: category,
                  );
                }).toList(),
                menuStyle: MenuStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 18,
                  ),
                  elevation: 8,
                  shadowColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 22.0,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text('Generate New Quote'),
                ],
              ),
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
