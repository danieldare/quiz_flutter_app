import 'package:flutter/material.dart';
import 'package:second_app/data/questions.dart';
import 'package:second_app/models/selected_answers.dart';
import 'package:second_app/questions_summary.dart';
import 'package:second_app/models/summary_data.dart';

import 'package:second_app/extension/string_extension.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.selectedAnswers, required this.restartQuiz});

  final List<SelectedAnswer> selectedAnswers;
  final void Function() restartQuiz;

  List<SummaryData> getSummaryData() {
    List<SummaryData> summary = [];

    selectedAnswers.asMap().forEach((index, answer) {
      summary.add(SummaryData(
        questionIndex: index,
        question: questions[index],
        correctAnswer: questions[index].correctAnswer,
        userAnswer: selectedAnswers[index].answer,
      ));
    });

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    var summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectAnswers = summaryData
        .where((answer) => answer.correctAnswer == answer.userAnswer)
        .length;

    return SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "You have answered $numCorrectAnswers out of $numTotalQuestions questions correctly!"
                  .capitalize(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                height: 1.5, // Set the line height
                fontSize: 17,
                color: Color.fromARGB(255, 254, 119, 164),
              ),
            ),
            const SizedBox(height: 30),
            QuestionsSummary(summaryData: summaryData),
            const SizedBox(height: 30),
            OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 124, 44, 185),
                ),
                onPressed: restartQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text("Restart Quiz"))
          ]),
        ));
  }
}
