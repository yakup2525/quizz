// lib/main.dart
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'feature/feature.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizViewModel(),
      child: MaterialApp(
        title: 'Quiz Uygulaması',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
