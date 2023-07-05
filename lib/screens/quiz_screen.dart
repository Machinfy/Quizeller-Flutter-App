import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/question_body.dart';
import 'package:quiz_app/widgets/results_body.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var currentQuestionIndex = 0;

  var userAnswers = <String>[];

  void goToNextQuestion(String selectedAnswer) {
    userAnswers.add(selectedAnswer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  void resetQuiz() {
    userAnswers.clear();
    setState(() {
      currentQuestionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('******** Current Screen is: (QuizScreen) ********');
    print('currentQuestionIndex is $currentQuestionIndex');
    print(userAnswers);
    return Scaffold(
      appBar: AppBar(title: const Text('Quizeller')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: currentQuestionIndex > 5
              ? ResultsBody(
                  onRestartPressed: resetQuiz,
                  userAnswers: userAnswers,
                )
              : QuestionBody(
                  currentQuestionIndex: currentQuestionIndex,
                  onAnswerPressed: goToNextQuestion),
        ),
      ),
    );
  }
}
