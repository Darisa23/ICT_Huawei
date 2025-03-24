// lib/screens/mood_graph_screen.dart

import 'package:flutter/material.dart';
// Importa la clase Mood (asumiendo que está en un archivo llamado mood.dart)
import '../models/mood_option.dart';  // Ajusta la ruta según tu estructura de proyecto

class MoodGraphScreen extends StatelessWidget {
  final MoodOption selectedMood; 
  
  const MoodGraphScreen({Key? key, required this.selectedMood}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para la gráfica
    final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final List<String> moods = ['😁', '😊', '😐', '😔', '😡'];
    
    // Datos de ejemplo - en una app real, estos vendrían de almacenamiento local o una base de datos
    final Map<String, String> moodData = {
      'Mon': '😁',
      'Tue': '😊',
      'Wed': '😔',
      'Thu': '😐',
      'Fri': '😁',
      'Sat': '😊',
      'Sun': selectedMood.emoji, // Usando el mood seleccionado para hoy
    };
    
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 230, 196, 1),
      appBar: AppBar(
        title: const Text('Your Mood Graph'),
        backgroundColor: const Color.fromRGBO(252, 230, 196, 1),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Mood Tracker',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'See how your mood has changed over the week:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            
            // Gráfica de estados de ánimo
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
  padding: const EdgeInsets.symmetric(vertical: 27),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: moods.map((mood) => Text(
      mood,
      style: const TextStyle(fontSize: 24),
    )).toList(),
  ),
),
                    const SizedBox(width: 15),
                    
                    // Gráfica principal
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: weekdays.map((day) {
                          final dayMood = moodData[day] ?? '😐';
                          final moodIndex = moods.indexOf(dayMood);
                          
                          return Expanded(
                            child: Column(
                              children: [
                                // Determinar la posición del marcador basado en el índice del estado de ánimo
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      // Calcular la posición vertical del marcador
                                      final paddingValue = 30.0; 
final availableHeight = constraints.maxHeight - (paddingValue * 2);
final segmentHeight = availableHeight / (moods.length - 1);
final position = paddingValue + segmentHeight * (moods.length - 1 - moodIndex)+8;
                                      return Stack(
                                        children: [
                                          // Línea vertical
                                          Center(
                                            child: Container(
                                              width: 1,
                                              height: constraints.maxHeight,
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          
                                          // Marcador de estado de ánimo
                                          Positioned(
                                            top: position - 12, // Ajustar para centrar el marcador
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: day == weekdays.last ? selectedMood.color : Colors.blue.shade200,
                                                shape: BoxShape.circle,
                                              ),
                                              padding: const EdgeInsets.all(1),
                                              child: Text(
                                                dayMood,
                                                style: const TextStyle(fontSize: 20),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                
                                // Etiqueta del día
                                Text(
                                  day,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: day == weekdays.last ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
                  'Back to Mood Selection',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}