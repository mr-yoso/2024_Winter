import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile Interface'),
        ),
        body: ProfileInterface(),
      ),
    );
  }
}

class ProfileInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.green, // Set your desired background color
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            // Insert your logo here
            child: Icon(Icons.person_outline, size: 40),
          ),
          SizedBox(height: 16),
          Text(
            'Your Name',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'MOBILE DEVELOPER',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 24),
          ContactInfo(icon: Icons.phone, text: '+84 123456789'),
          ContactInfo(icon: Icons.email, text: 'your.email@example.com'),
          ContactInfo(icon: Icons.apple, text: '@your_twitter'),
          ContactInfo(icon: Icons.link, text: 'yourwebsite.com'),
        ],
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  ContactInfo({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
