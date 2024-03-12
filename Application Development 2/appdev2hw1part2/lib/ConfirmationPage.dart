import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int? guests = arguments['guests'] as int?;
    final int? rooms = arguments['rooms'] as int?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You booked $guests guests and $rooms rooms.\nthanks',
              style: TextStyle(
                fontSize: 36.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
