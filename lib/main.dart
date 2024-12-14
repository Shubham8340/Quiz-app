import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Berlin', 'Madrid', 'Paris', 'Rome'],
      'answer': 2
    },
    {
      'question': 'What is 2 + 2?',
      'options': ['3', '4', '5', '6'],
      'answer': 1
    },
    {
      'question': 'Which programming language is used in Flutter?',
      'options': ['Python', 'Java', 'Dart', 'C++'],
      'answer': 2
    },
  ];

  int currentQuestion = 0;
  int score = 0;

  void answerQuestion(int selectedIndex) {
    if (selectedIndex == questions[currentQuestion]['answer']) {
      score++;
    }
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(score, questions.length, restartQuiz),
        ),
      );
    }
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
    });
    Navigator.pop(context); // Return to the quiz screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questions[currentQuestion]['question'],
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            ...questions[currentQuestion]['options'].map((option) {
              int index = questions[currentQuestion]['options'].indexOf(option);
              return ElevatedButton(
                onPressed: () => answerQuestion(index),
                child: Text(option),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback restartQuiz;

  ResultPage(this.score, this.totalQuestions, this.restartQuiz);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score / $totalQuestions',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: restartQuiz,
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
