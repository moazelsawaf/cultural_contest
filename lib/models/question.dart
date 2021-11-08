import 'package:cultural_contest/models/category.dart';

class Question {
  final int id;
  final Category category;
  final String question;
  final String answer;

  const Question({
    this.id,
    this.category,
    this.question,
    this.answer,
  });
}
