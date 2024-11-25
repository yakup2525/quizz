import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  final String question;
  final List<String> options;
  final String longAnswer;
  final int answer;

  Question({
    required this.question,
    required this.options,
    required this.longAnswer,
    required this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
