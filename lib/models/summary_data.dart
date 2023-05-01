import 'package:second_app/models/quiz_question.dart';
import 'package:uuid/uuid.dart';

class SummaryData {
  final int questionIndex;
  final QuizQuestion question;
  final String correctAnswer;
  final String userAnswer;

  SummaryData({
    required this.questionIndex,
    required this.question,
    required this.correctAnswer,
    required this.userAnswer,
  });
}
