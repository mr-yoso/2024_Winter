import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String appTitle = "Mt. Fuji";
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/fuji.jpg'),
              TitleSection(
                name: "Mt. Fuji",
                location: "Fuji, Japan",
              ),
              ButtonSection(),
              TextSection(
                  description:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed "
                      "do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                      "Ut enim ad minim veniam, quis nostrud exercitation ullamco "
                      "laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure"
                      " dolor in reprehenderit in voluptate velit esse cillum dolore "
                      "eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non "
                      "proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
            ],
          ),
        ),
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  final String description;

  TextSection({
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(35),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonText(color: color, icon: Icons.call, label: "CAL"),
          ButtonText(color: color, icon: Icons.near_me, label: "Route"),
          ButtonText(color: color, icon: Icons.share, label: "Share"),
        ],
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;

  ButtonText({
    required this.color,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}

class TitleSection extends StatelessWidget {
  final String name;
  final String location;

  TitleSection({
    required this.name,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                location,
                style: TextStyle(color: Colors.lightGreen),
              )
            ],
          )),
          Icon(
            Icons.star,
            color: Colors.red,
          ),
          Text("41"),
        ],
      ),
    );
  }
}
