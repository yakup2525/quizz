// lib/widgets/question_widget.dart
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '/feature/feature.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;

  const QuestionWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final quizVM = Provider.of<QuizViewModel>(context);
    final currentIndex = quizVM.currentQuestionIndex;
    final selectedOption = quizVM.selectedAnswers[currentIndex];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...List.generate(question.options.length, (index) {
            return OptionWidget(
              optionText: question.options[index],
              isSelected: selectedOption == index,
              onTap: () {
                quizVM.selectAnswer(index);
              },
            );
          }),
        ],
      ),
    );
  }
}
