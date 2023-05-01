import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_app/models/summary_data.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<SummaryData> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            var isCorrectAnswer = data.correctAnswer == data.userAnswer;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: isCorrectAnswer
                      ? const Color.fromARGB(255, 40, 213, 240)
                      : const Color.fromARGB(255, 216, 62, 114),
                  child: Text(
                    (data.questionIndex + 1).toString(),
                    style: GoogleFonts.lato(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.question.question,
                        style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 236, 225, 229),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(data.userAnswer,
                          style: GoogleFonts.lato(
                              color: const Color.fromARGB(255, 216, 62, 114),
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 1),
                      Text(data.correctAnswer,
                          style: GoogleFonts.lato(
                              color: const Color.fromARGB(255, 40, 213, 240),
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 7),
                    ],
                  ),
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
