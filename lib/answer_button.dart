import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(
      {required this.answerText,
      required this.onTap,
      required this.isSelectedAnswer,
      super.key});

  final String answerText;
  final void Function() onTap;
  final bool isSelectedAnswer;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            foregroundColor: Colors.white,
            backgroundColor: isSelectedAnswer
                ? const Color.fromARGB(77, 111, 11, 147)
                : const Color.fromARGB(77, 186, 95, 222),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          answerText,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
              fontWeight: isSelectedAnswer ? FontWeight.w600 : FontWeight.w400),
        ));
  }
}
