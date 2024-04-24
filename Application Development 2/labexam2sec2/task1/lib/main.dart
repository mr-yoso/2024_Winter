import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final player = AudioPlayer();

  void playSound(String soundPath) {
    player.play(AssetSource(soundPath));
  }

  Widget buildListTile({required Color color, required String soundPath}) {
    return ListTile(
      tileColor: color,
      onTap: () {
        playSound(soundPath);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Xylophone',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Xylophone'),
        ),
        body: ListView(
          children: [
            buildListTile(color: Colors.red, soundPath: 'assets/note1.mp3'),
            buildListTile(color: Colors.orange, soundPath: 'assets/note2.mp3'),
            buildListTile(color: Colors.yellow, soundPath: 'assets/note3.mp3'),
            buildListTile(color: Colors.green, soundPath: 'assets/note4.mp3'),
            buildListTile(color: Colors.teal, soundPath: 'assets/note5.mp3'),
            buildListTile(color: Colors.blue, soundPath: 'assets/note6.mp3'),
            buildListTile(color: Colors.purple, soundPath: 'assets/note7.mp3'),
          ],
        ),
      ),
    );
  }
}