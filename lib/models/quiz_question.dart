import 'package:uuid/uuid.dart';

class QuizQuestion {
  final String id;
  final String question;
  final List<String> answers;
  final String correctAnswer;

  QuizQuestion(
      {required this.question,
      required this.answers,
      required this.correctAnswer})
      : id = const Uuid().v4();

  List<String> getShuffledAnswers() {
    final shuffledAnswers = List.of(answers);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }
}
