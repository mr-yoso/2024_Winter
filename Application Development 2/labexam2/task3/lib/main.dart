import 'package:flutter/material.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int currentGender = 0;
  double height = 1;
  double weight = 55;
  int age = 40;
  double bmi = 0;
  String? result;

  void calculateBMI() {
    final double heightInMeters = height / 3.281;
    final double calculatedBMI = weight / (heightInMeters * heightInMeters);

    setState(() {
      bmi = calculatedBMI;
      if (bmi < 18.5) {
        result = 'Underweight';
      } else if (bmi < 25) {
        result = 'Normal';
      } else if (bmi < 30) {
        result = 'Overweight';
      } else {
        result = 'Obese';
      }
    });
  }

  Widget genderIcon(IconData icon, String text, int gender) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 80),
          onPressed: () => setState(() => currentGender = gender),
        ),
        Text(text),
        if (currentGender == gender) Icon(Icons.check, color: Colors.green)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                genderIcon(Icons.male, 'MALE', 0),
                genderIcon(Icons.female, 'FEMALE', 1),
              ],
            ),
            SizedBox(height: 24),
            Slider(
              value: height,
              min: 1.0,
              max: 10.0,
              onChanged: (double newValue) {
                setState(() {
                  height = newValue;
                });
              },
            ),
            Text(
              'Height: ${height.toStringAsFixed(1)} ft',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Weight: ${weight.toInt()} kg', style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => setState(() {
                        if (weight > 1) weight--;
                      }),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => setState(() {
                        weight++;
                      }),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Age: $age years', style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => setState(() {
                        if (age > 1) age--;
                      }),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => setState(() {
                        age++;
                      }),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Your BMI'),
                    content: Text('${bmi.toStringAsFixed(2)} - $result'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
              child: Text('CALCULATE'),
            ),
          ],
        ),
      ),
    );
  }
}
