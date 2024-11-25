// lib/views/result_page.dart
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '/feature/feature.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizVM = Provider.of<QuizViewModel>(context, listen: false);
    final score = quizVM.calculateScore();
    final totalQuestions = quizVM.quizQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sonuç'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Toplam Puan: $score/${totalQuestions * 2}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: totalQuestions,
                itemBuilder: (context, index) {
                  return ResultQuestionWidget(
                    questionIndex: index,
                    question: quizVM.quizQuestions[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                quizVM.resetQuiz();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Tekrar Dene'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Anasayfaya Dön'),
            ),
          ],
        ),
      ),
    );
  }
}
