import 'package:flutter/material.dart';
import 'package:second_app/data/questions.dart';
import 'package:second_app/init_screen.dart';
import 'package:second_app/models/selected_answers.dart';
import 'package:second_app/questions_screen.dart';
import 'package:second_app/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<SelectedAnswer> selectedAnswers = [];
  Widget? activeScreen;

  @override
  void initState() {
    activeScreen = InitScreen(switchScreen);
    super.initState();
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = QuestionsScreen(
          onSelectAnswer: chooseAnswer,
          onShowResults: showResults,
          selectedAnswers: selectedAnswers);
    });
  }

  void showResults() {
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(
          selectedAnswers: selectedAnswers,
          restartQuiz: restartQuiz,
        );
      });
    }
  }

  void chooseAnswer(String answer, String questionId) {
    SelectedAnswer foundAnswer = selectedAnswers.firstWhere(
      (element) => element.questionId == questionId,
      orElse: () => SelectedAnswer(questionId: "", answer: ""),
    );

    if (foundAnswer.answer.isNotEmpty) {
      // Since SelectedAnswer properties are final, we need to replace the object instead of modifying it
      int index = selectedAnswers.indexOf(foundAnswer);
      selectedAnswers[index] =
          SelectedAnswer(questionId: questionId, answer: answer);
    } else {
      selectedAnswers
          .add(SelectedAnswer(questionId: questionId, answer: answer));
    }
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(
          onSelectAnswer: chooseAnswer,
          onShowResults: showResults,
          selectedAnswers: selectedAnswers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 74, 36, 140),
              Color.fromARGB(255, 54, 23, 108),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: activeScreen),
      ),
    );
  }
}
