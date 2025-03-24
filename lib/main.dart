import 'package:flutter/material.dart';
import 'models/mood_option.dart';
import 'screens/mood_graph_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override //este es el widget raíz.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApoyoVivo',
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
      backgroundColor: const Color.fromRGBO(250, 242, 233, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aquí puedes colocar el logo de tu app
            // Por ejemplo, un placeholder:
            Image.asset(
              'assets/apoyoVivoLogo.png',
              width: 270,
              height: 200,
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
      color: const Color.fromRGBO(252, 230, 196, 1),
    ),
    MoodOption(
      emoji: '🙂',
      label: 'Good',
      color: const Color.fromRGBO(202, 236, 228, 1),
    ),
    MoodOption(
      emoji: '😐',
      label: 'Neutral',
      color: const Color.fromRGBO(255, 213, 239, 1),
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
      backgroundColor: _selectedMood?.color ?? const Color.fromRGBO(252, 230, 196, 1),
      appBar: AppBar(
        title: Image.asset('assets/apoyoVivoLogo.png', height: 55),
        centerTitle: true,
      backgroundColor: _selectedMood?.color ?? const Color.fromRGBO(252, 230, 196, 1),
      ),
    
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top:60),
              child: Text(
                'How  do  you  feel  today?',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),

              if (_selectedMood != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Text(
              _selectedMood!.emoji,
              style: const TextStyle(fontSize: 100),
            ),
          ),
        
        // Espacio flexible para distribuir mejor los elementos
        const Spacer(),
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
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: _selectedMood == mood
                          ? mood.color
                          : Colors.white,
                      borderRadius: BorderRadius.circular(35),
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
            const SizedBox(height: 90),
            if (_selectedMood != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'You are feeling ${_selectedMood!.label}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
           // Botón "Note Mood"
        if (_selectedMood != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton(
              onPressed: () {
  final selectedMood = _selectedMood; // Crea una copia local
  if (selectedMood != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoodGraphScreen(selectedMood: selectedMood),
      ),
    );
  }
},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Note Mood',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        // Espacio adicional en la parte inferior
        const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}