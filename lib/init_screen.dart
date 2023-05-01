import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitScreen extends StatelessWidget {
  const InitScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          "assets/images/quiz_logo.png",
          width: 250,
        ),
        const SizedBox(height: 50),
        Text(
          'Learn Flutter the fun way!',
          style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 214, 154, 154),
              fontSize: 18,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 40),
        OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(13),
              backgroundColor: const Color.fromARGB(21, 255, 255, 255),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            icon: const Icon(
              Icons.arrow_right_alt,
            ),
            label: Text("Start Quiz",
                style: GoogleFonts.lato(color: Colors.white, fontSize: 13))),
      ]),
    );
  }
}
