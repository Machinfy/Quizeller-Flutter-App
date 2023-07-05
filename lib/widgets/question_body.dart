import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_question.dart';

class QuestionBody extends StatelessWidget {
  const QuestionBody(
      {super.key,
      required this.currentQuestionIndex,
      required this.onAnswerPressed});

  final int currentQuestionIndex;
  final void Function(String) onAnswerPressed;
  //final VoidCallback onAnswerPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: AutoSizeText(
              kQuestions[currentQuestionIndex].questionText,
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Column(
            children: kQuestions[currentQuestionIndex]
                .shuffledAnswers
                .map((answerText) {
              return AnswerButton(
                answer: answerText,
                onPressed: () {
                  //userAnswers.add(answerText);
                  onAnswerPressed(answerText);
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class AnswerButton extends StatelessWidget {
  const AnswerButton(
      {super.key, required this.answer, required this.onPressed});

  final String answer;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          onPressed: onPressed,
          style: const ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
          ),
          child: AutoSizeText(
            answer,
            maxLines: 2,
            minFontSize: 10,
          ),
        ),
      ),
    );
  }
}
