// lib/models/mood.dart
import 'package:flutter/material.dart';

class MoodOption {
  final String emoji;
  final String label;
  final Color color;
  
  const MoodOption({
    required this.emoji,
    required this.label,
    required this.color,
  });
}
