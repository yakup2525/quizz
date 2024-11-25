// lib/views/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/feature/feature.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizVM = Provider.of<QuizViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Uygulaması'),
      ),
      body: quizVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ElevatedButton(
                child: const Text('Quize Başla'),
                onPressed: () {
                  quizVM.resetQuiz();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                },
              ),
            ),
    );
  }
}
