import 'package:advbasics/data/questions.dart';
import 'package:advbasics/question_summary.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.chosenAnswer});

  void onRestart() {}
  final List<String> chosenAnswer;

  List<Map<String, Object>> getSummary() {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < chosenAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'question_Answer': questions[i].answers[0],
        'your_Answer': chosenAnswer[i]
      });
    }
    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummary();
    final totalQuestions = questions.length;
    final correctQuestions = summaryData.where((data) {
      return (data['question_Answer'] == data['your_Answer']);
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'you answered $correctQuestions out of $totalQuestions questions correctly!'),
            const SizedBox(height: 30),
            QuestionSummary(summaryData),
            const SizedBox(height: 30),
            TextButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz'),
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
