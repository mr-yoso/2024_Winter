import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> widgetOptions = [
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/tokyo_tower.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                'The best travel\nin the world',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'lives without limits the world is made to'
                '\nexplore and appreciate its beauty',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'Explore now',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    GridView.count(
      crossAxisCount: 3,
      children: [
        Image.asset('assets/treasure_map.jpg'),
        Image.asset('assets/ship.jpg'),
        Image.asset('assets/airplane.png'),
        Image.asset('assets/ship.jpg'),
        Image.asset('assets/airplane.png'),
        Image.asset('assets/treasure_map.jpg'),
        Image.asset('assets/airplane.png'),
        Image.asset('assets/treasure_map.jpg'),
        Image.asset('assets/ship.jpg'),
      ],
    ),
    ListView(
      children: [
        TemperatureConverter(),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "HOME",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "SEARCH",
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "SETTINGS",
              backgroundColor: Colors.blue),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  double _temperature = 0.0;
  String _result = '';

  void _convertTemperature() {
    if (_temperature != null) {
      double result = _temperature * 9 / 5 + 32;
      setState(() {
        _result = _temperature.toStringAsFixed(1) +
            '°C = ' +
            result.toStringAsFixed(1) +
            '°F';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter temperature in Celsius',
          ),
          onChanged: (text) {
            setState(() {
              _temperature = double.tryParse(text) ?? 0.0;
            });
          },
        ),
        ElevatedButton(
          onPressed: _convertTemperature,
          child: Text('Convert to Fahrenheit'),
        ),
        Text(_result),
      ],
    );
  }
}
