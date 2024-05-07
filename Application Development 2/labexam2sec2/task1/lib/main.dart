import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<void> playSound(String soundPath) async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource(soundPath));
  }

  Widget buildListTile({required Color color, required String soundPath}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: ListTile(
          tileColor: color,
          onTap: () => playSound(soundPath),
        ),
      ),
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
            buildListTile(color: Colors.red, soundPath: 'sounds/note1.mp3'),
            buildListTile(color: Colors.orange, soundPath: 'sounds/note2.mp3'),
            buildListTile(color: Colors.yellow, soundPath: 'sounds/note3.mp3'),
            buildListTile(color: Colors.green, soundPath: 'sounds/note4.mp3'),
            buildListTile(color: Colors.teal, soundPath: 'sounds/note5.mp3'),
            buildListTile(color: Colors.blue, soundPath: 'sounds/note6.mp3'),
            buildListTile(color: Colors.purple, soundPath: 'sounds/note7.mp3'),
          ],
        ),
      ),
    );
  }
}
