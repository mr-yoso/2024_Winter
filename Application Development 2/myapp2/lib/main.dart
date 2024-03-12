import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int teamAScore = 0;
  int teamBScore = 0;

  void addToScore(int team, int points) {
    setState(() {
      if (team == 0) {
        teamAScore += points;
      } else {
        teamBScore += points;
      }
    });
  }

  void resetGame() {
    setState(() {
      teamAScore = 0;
      teamBScore = 0;
    });
  }

  String determineWinner() {
    if (teamAScore > teamBScore) {
      return "Team A Wins!";
    } else if (teamBScore > teamAScore) {
      return "Team B Wins!";
    } else {
      return "It's a Tie!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Basketball Game"),
        ),
        body: Column(
          children: [
            // Team scores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Team A"),
                    Image.asset(
                      'assets/kobe.jpg',
                      width: 150,
                      height: 150,
                    ),
                    Text("$teamAScore"),
                    // Buttons for Team A
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => addToScore(0, 1),
                          child: Text("+1"),
                        ),
                        ElevatedButton(
                          onPressed: () => addToScore(0, 2),
                          child: Text("+2"),
                        ),
                        ElevatedButton(
                          onPressed: () => addToScore(0, 4),
                          child: Text("+4"),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Team B"),
                    Image.asset(
                      'assets/curry.jpg',
                      width: 150,
                      height: 150,
                    ),
                    Text("$teamBScore"),
                    // Buttons for Team B
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => addToScore(1, 1),
                          child: Text("+1"),
                        ),
                        ElevatedButton(
                          onPressed: () => addToScore(1, 2),
                          child: Text("+2"),
                        ),
                        ElevatedButton(
                          onPressed: () => addToScore(1, 4),
                          child: Text("+4"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // Reset and Determine Winner buttons
            Column(
              children: [
                ElevatedButton(
                  onPressed: resetGame,
                  child: Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(determineWinner()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  ),
                  child: Text("Determine Winner"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
