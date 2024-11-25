// lib/views/quiz_page.dart
import 'package:flutter/material.dart';
import '/feature/feature.dart';

import 'package:provider/provider.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, quizVM, child) {
        if (quizVM.isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quiz'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (quizVM.quizQuestions.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quiz'),
            ),
            body: const Center(child: Text('No questions available')),
          );
        }

        final question = quizVM.quizQuestions[quizVM.currentQuestionIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Soru ${quizVM.currentQuestionIndex + 1}/${quizVM.quizQuestions.length}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(child: QuestionWidget(question: question)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: quizVM.currentQuestionIndex > 0
                          ? () {
                              quizVM.previousQuestion();
                            }
                          : null,
                      child: const Text('Önceki'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (quizVM.currentQuestionIndex ==
                            quizVM.quizQuestions.length - 1) {
                          // Quiz tamamlandı
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultPage()),
                          );
                        } else {
                          quizVM.nextQuestion();
                        }
                      },
                      child: Text(quizVM.currentQuestionIndex ==
                              quizVM.quizQuestions.length - 1
                          ? 'Sonuç'
                          : 'Sonraki'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    quizVM.skipQuestion();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Atla'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
