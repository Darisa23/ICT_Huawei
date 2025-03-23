// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Pantalla de carga (Splash Screen)
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simular tiempo de carga
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MoodSelectionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aquí puedes colocar el logo de tu app
            // Por ejemplo, un placeholder:
            const Icon(
              Icons.sentiment_satisfied_alt,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

// Pantalla de selección de estado de ánimo
class MoodSelectionScreen extends StatefulWidget {
  const MoodSelectionScreen({Key? key}) : super(key: key);

  @override
  State<MoodSelectionScreen> createState() => _MoodSelectionScreenState();
}

class _MoodSelectionScreenState extends State<MoodSelectionScreen> {
  // Definir los diferentes estados de ánimo
  final List<MoodOption> _moodOptions = [
    MoodOption(
      emoji: '😀',
      label: 'Happy',
      color: Colors.yellow.shade200,
    ),
    MoodOption(
      emoji: '😐',
      label: 'Neutral',
      color: Colors.grey.shade200,
    ),
    MoodOption(
      emoji: '😔',
      label: 'Sad',
      color: Colors.blue.shade200,
    ),
    MoodOption(
      emoji: '😡',
      label: 'Angry',
      color: Colors.red.shade200,
    ),
  ];

  MoodOption? _selectedMood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMood?.color ?? Colors.white,
      appBar: AppBar(
        title: const Text('Mood App'),
        elevation: 0,
        backgroundColor: _selectedMood?.color ?? Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'How do you feel today?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _moodOptions.map((mood) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMood = mood;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _selectedMood == mood
                          ? mood.color
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      mood.emoji,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 50),
            if (_selectedMood != null)
              Column(
                children: [
                  Text(
                    _selectedMood!.emoji,
                    style: const TextStyle(fontSize: 100),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'You are feeling ${_selectedMood!.label}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// Clase para representar una opción de estado de ánimo
class MoodOption {
  final String emoji;
  final String label;
  final Color color;

  MoodOption({
    required this.emoji,
    required this.label,
    required this.color,
  });
}