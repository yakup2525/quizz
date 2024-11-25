// lib/widgets/result_question_widget.dart
import 'package:flutter/material.dart';
import '/feature/feature.dart';

import 'package:provider/provider.dart';

class ResultQuestionWidget extends StatelessWidget {
  final int questionIndex;
  final Question question;

  const ResultQuestionWidget({
    super.key,
    required this.questionIndex,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final quizVM = Provider.of<QuizViewModel>(context, listen: false);
    final selectedOption = quizVM.selectedAnswers[questionIndex];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Soru ${questionIndex + 1}:',
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6.0),
            Text(question.question, style: const TextStyle(fontSize: 16.0)),
            const SizedBox(height: 12.0),
            Column(
              children: List.generate(question.options.length, (optionIndex) {
                Color optionColor = Colors.black;
                if (optionIndex == question.answer) {
                  optionColor = Colors.green;
                }
                if (selectedOption != null) {
                  if (optionIndex == selectedOption &&
                      selectedOption != question.answer) {
                    optionColor = Colors.red;
                  }
                }

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    question.options[optionIndex],
                    style: TextStyle(
                      color: optionColor,
                      fontSize: 16.0,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
