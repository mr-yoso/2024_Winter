import 'package:appdev2hw1part2/ReservationPage.dart';
import 'package:flutter/material.dart';
import 'ConfirmationPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel reservation example',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        '/': (context) => ReservationPage(),
        '/Second': (context) => ConfirmationPage(),
      },
    );
  }
}
