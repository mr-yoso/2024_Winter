import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'True or False Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _questionIndex = Random().nextInt(10);
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'text': 'The blue whale is the biggest animal to have ever lived.',
      'answer': true
    },
    {'text': 'An ant can lift 1,000 times its body weight.', 'answer': false},
    {
      'text': 'The Atlantic Ocean is the biggest ocean on Earth.',
      'answer': false
    },
    {
      'text': 'Mount Everest is the tallest mountain in the world.',
      'answer': true
    },
    {'text': 'Human skin regenerates every week.', 'answer': false},
    {
      'text': 'The average human sneeze can be clocked at 100 miles an hour.',
      'answer': true
    },
    {'text': 'Hawaiian pizza comes from Canada.', 'answer': true},
    {
      'text':
          'Mcdonald\'s has the most restaurants by location in the United States.',
      'answer': false
    },
    {
      'text': 'Three strikes in a row in bowling is called a chicken.',
      'answer': false
    },
    {
      'text':
          'Brazil is the only nation to have played in every World Cup finals tournament.',
      'answer': true
    },
  ];

  void _answerQuestion(bool userAnswer) {
    if (_questions[_questionIndex]['answer'] == userAnswer) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _questionIndex = Random().nextInt(10);
      });
    } else {
      _showFinalScore();
      _questionIndex = Random().nextInt(10);
    }
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Your score: $_score/${_questions.length}'),
        content: Text('Finished \nYou\'ve reached the end of the quiz.'),
        actions: <Widget>[
          TextButton(
            child: Text('Restart'),
            onPressed: () {
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
              });
              Navigator.of(ctx).pop(); // Close the dialog
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('True or False Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _questions[_questionIndex]['text'],
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      'True',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _answerQuestion(true),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(
                      'False',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _answerQuestion(false),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
