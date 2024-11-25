// lib/view_models/quiz_view_model.dart
import 'dart:convert';
import 'dart:math';
import '/feature/feature.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class QuizViewModel extends ChangeNotifier {
  List<Question> _allQuestions = [];
  List<Question> _quizQuestions = [];
  Map<int, int> _selectedAnswers =
      {}; // question index -> selected option index
  int _currentQuestionIndex = 0;
  bool _isLoading = true;

  List<Question> get quizQuestions => _quizQuestions;
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get isLoading => _isLoading;
  Map<int, int> get selectedAnswers => _selectedAnswers;

  QuizViewModel() {
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      final String response =
          await rootBundle.loadString('assets/questions.json');
      final List<dynamic> data = json.decode(response);
      _allQuestions = data.map((q) => Question.fromJson(q)).toList();
      _selectRandomQuestions();
    } catch (e) {
      print('Error loading questions: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  void _selectRandomQuestions() {
    _quizQuestions = [];
    _selectedAnswers = {};
    _currentQuestionIndex = 0;

    if (_allQuestions.length <= 50) {
      _quizQuestions = List.from(_allQuestions);
    } else {
      var random = Random();
      Set<int> selectedIndices = {};
      while (selectedIndices.length < 50) {
        selectedIndices.add(random.nextInt(_allQuestions.length));
      }
      _quizQuestions =
          selectedIndices.map((index) => _allQuestions[index]).toList();
    }
  }

  void selectAnswer(int optionIndex) {
    _selectedAnswers[_currentQuestionIndex] = optionIndex;
    notifyListeners();
  }

  void skipQuestion() {
    _currentQuestionIndex++;
    if (_currentQuestionIndex >= _quizQuestions.length) {
      _currentQuestionIndex = _quizQuestions.length - 1;
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < _quizQuestions.length; i++) {
      if (_selectedAnswers.containsKey(i) &&
          _selectedAnswers[i] == _quizQuestions[i].answer) {
        score += 2;
      }
    }
    return score;
  }

  List<int> getIncorrectAnswers() {
    List<int> incorrect = [];
    for (int i = 0; i < _quizQuestions.length; i++) {
      if (!_selectedAnswers.containsKey(i) ||
          _selectedAnswers[i] != _quizQuestions[i].answer) {
        incorrect.add(i);
      }
    }
    return incorrect;
  }

  void resetQuiz() {
    _selectRandomQuestions();
    notifyListeners();
  }
}



// // lib/view_models/quiz_view_model.dart
// import 'dart:convert';
// import 'dart:math';
// import '/feature/feature.dart';

// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';

// class QuizViewModel extends ChangeNotifier {
//   List<Question> _allQuestions = [];
//   List<Question> _quizQuestions = [];
//   Map<int, int> _selectedAnswers =
//       {}; // question index -> selected option index
//   int _currentQuestionIndex = 0;
//   bool _isLoading = true;

//   List<Question> get quizQuestions => _quizQuestions;
//   int get currentQuestionIndex => _currentQuestionIndex;
//   bool get isLoading => _isLoading;
//   Map<int, int> get selectedAnswers => _selectedAnswers;

//   QuizViewModel() {
//     loadQuestions();
//   }

//   Future<void> loadQuestions() async {
//     try {
//       final String response =
//           await rootBundle.loadString('assets/questions.json');
//       final List<dynamic> data = json.decode(response);
//       _allQuestions = data.map((q) => Question.fromJson(q)).toList();
//       _selectRandomQuestions();
//     } catch (e) {
//       debugPrint('Error loading questions: $e');
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   void _selectRandomQuestions() {
//     _quizQuestions = [];
//     _selectedAnswers = {};
//     _currentQuestionIndex = 0;

//     if (_allQuestions.length <= 50) {
//       _quizQuestions = List.from(_allQuestions);
//     } else {
//       var random = Random();
//       Set<int> selectedIndices = {};
//       while (selectedIndices.length < 50) {
//         selectedIndices.add(random.nextInt(_allQuestions.length));
//       }
//       _quizQuestions =
//           selectedIndices.map((index) => _allQuestions[index]).toList();
//     }
//   }

//   void selectAnswer(int optionIndex) {
//     _selectedAnswers[_currentQuestionIndex] = optionIndex;
//     notifyListeners();
//   }

//   void skipQuestion() {
//     _currentQuestionIndex++;
//     if (_currentQuestionIndex >= _quizQuestions.length) {
//       _currentQuestionIndex = _quizQuestions.length - 1;
//     }
//     notifyListeners();
//   }

//   void nextQuestion() {
//     if (_currentQuestionIndex < _quizQuestions.length - 1) {
//       _currentQuestionIndex++;
//       notifyListeners();
//     }
//   }

//   void previousQuestion() {
//     if (_currentQuestionIndex > 0) {
//       _currentQuestionIndex--;
//       notifyListeners();
//     }
//   }

//   int calculateScore() {
//     int score = 0;
//     for (int i = 0; i < _quizQuestions.length; i++) {
//       if (_selectedAnswers.containsKey(i) &&
//           _selectedAnswers[i] == _quizQuestions[i].answer) {
//         score += 2;
//       }
//     }
//     return score;
//   }

//   void resetQuiz() {
//     _selectRandomQuestions();
//     notifyListeners();
//   }
// }
