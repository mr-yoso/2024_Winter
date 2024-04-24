import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Roller',
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Roll the Dice'),
          backgroundColor: Colors.redAccent,
        ),
        body: DicePage(),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  void rollDice() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1; // Dice number from 1 to 6
      rightDiceNumber = Random().nextInt(6) + 1; // Dice number from 1 to 6
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'The sum is: ${leftDiceNumber + rightDiceNumber}',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: rollDice,
                  child: Image.asset('images/dice$leftDiceNumber.png', width: 100, height: 100), // Specify the correct path for your dice images
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: rollDice,
                  child: Image.asset('images/dice$rightDiceNumber.png', width: 100, height: 100), // Specify the correct path for your dice images
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: rollDice,
            child: Text(
              'Roll Dice',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}