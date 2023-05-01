import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_app/answer_button.dart';
import "package:second_app/data/questions.dart";
import 'package:second_app/models/quiz_question.dart';
import 'package:second_app/models/selected_answers.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(
      {required this.onSelectAnswer,
      required this.onShowResults,
      required this.selectedAnswers,
      super.key});

  final void Function(String answer, String questionId) onSelectAnswer;
  final void Function() onShowResults;
  final List<SelectedAnswer> selectedAnswers;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;
  String chosenAnswer = "";

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void answerQuestion(String selectedAnswer, String questionId) {
    widget.onSelectAnswer(selectedAnswer, questionId);
    setState(() {
      chosenAnswer = selectedAnswer;
    });
  }

  void previousQuestion() {
    if (_pageController.hasClients && _pageController.page! > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void nextQuestion() {
    if (_pageController.hasClients &&
        _pageController.page! < questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Handle the end of the quiz
      widget.onShowResults();
    }
  }

  String get userCurrentAnswer {
    final currentQuestion = questions[currentQuestionIndex];
    final userAnswer = widget.selectedAnswers.firstWhere(
        (element) => element.questionId == currentQuestion.id,
        orElse: () => SelectedAnswer(questionId: "", answer: ""));
    return userAnswer.answer;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: questions.length,
      itemBuilder: ((context, index) {
        QuizQuestion currentQuestion = questions[index];

        return Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${index + 1}. ${currentQuestion.question}",
                style: GoogleFonts.lato(
                  fontSize: 19,
                  color: const Color.fromARGB(255, 243, 154, 210),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ...currentQuestion.answers.map((answer) => AnswerButton(
                    answerText: answer,
                    isSelectedAnswer: answer == userCurrentAnswer,
                    onTap: () => answerQuestion(answer, currentQuestion.id),
                  )),
              const SizedBox(height: 40),

              // Add the previous and next buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentQuestionIndex > 0
                      ? OutlinedButton(
                          onPressed: previousQuestion,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            backgroundColor:
                                const Color.fromARGB(21, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text("Previous",
                              style: GoogleFonts.lato(
                                fontSize: 13,
                                color: const Color.fromARGB(255, 226, 133, 192),
                                fontWeight: FontWeight.w400,
                              )))
                      : Container(),
                  OutlinedButton(
                      onPressed: nextQuestion,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor:
                            const Color.fromARGB(21, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Next",
                          style: GoogleFonts.lato(
                            fontSize: 13,
                            color: const Color.fromARGB(255, 71, 232, 143),
                            fontWeight: FontWeight.w400,
                          )))
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
