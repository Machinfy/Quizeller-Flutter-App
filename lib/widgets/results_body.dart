import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_question.dart';

class ResultsBody extends StatelessWidget {
  ResultsBody(
      {super.key, required this.onRestartPressed, required this.userAnswers});

  final void Function() onRestartPressed;
  final List<String> userAnswers;

  int get _rightAnsweredQuestions {
    var rightQuestionCounter = 0;
    for (var i = 0; i < kQuestions.length; i++) {
      if (checkIfRightAnswer(i)) {
        rightQuestionCounter++;
      }
    }
    return rightQuestionCounter;
  }

  bool checkIfRightAnswer(int questionIndex) {
    return kQuestions[questionIndex].answers[0] == userAnswers[questionIndex];
  }

  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Text(
                  'You have answered $_rightAnsweredQuestions question correctly out of ${userAnswers.length} questions',
                  textAlign: TextAlign.center),
              ...userAnswers.map((userAnswer) {
                return QuestionResultListItem(
                  userAnswer: userAnswer,
                  correctAnswer: kQuestions[currentIndex].answers[0],
                  isCorrect: checkIfRightAnswer(currentIndex),
                  question: kQuestions[currentIndex].questionText,
                  questionNumber: ++currentIndex,
                );
              }).toList()
            ],
          ),
        ),
        TextButton.icon(
            icon: const Icon(Icons.refresh),
            onPressed: onRestartPressed,
            label: const Text('Restart quiz'))
      ],
    );
  }
}

class QuestionResultListItem extends StatelessWidget {
  const QuestionResultListItem(
      {super.key,
      required this.correctAnswer,
      required this.userAnswer,
      required this.isCorrect,
      required this.question,
      required this.questionNumber});

  final String question;
  final String correctAnswer;
  final String userAnswer;
  final int questionNumber;
  final bool isCorrect;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        child: Text(
          '$questionNumber',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(question),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(correctAnswer),
            Text(userAnswer),
          ],
        ),
      ),
    );
  }
}
