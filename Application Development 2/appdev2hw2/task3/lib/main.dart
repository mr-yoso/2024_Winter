import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WeatherData {
  final DateTime time;
  final double temperature2m;
  final double rain;
  final double showers;
  final double snowfall;
  final double cloudCover;
  final double cloudCoverLow;
  final double cloudCoverMid;
  final double cloudCoverHigh;

  WeatherData({
    required this.time,
    required this.temperature2m,
    required this.rain,
    required this.showers,
    required this.snowfall,
    required this.cloudCover,
    required this.cloudCoverLow,
    required this.cloudCoverMid,
    required this.cloudCoverHigh,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    // Use a helper function to safely get values from the JSON
    double getDouble(dynamic source) {
      try {
        if (source is int) {
          return source.toDouble();
        } else if (source is double) {
          return source;
        } else if (source is String) {
          return double.parse(source);
        }
        return 0.0;
      } catch (e) {
        print('Error parsing double value: $e');
        return 0.0;
      }
    }

    return WeatherData(
      time: DateTime.parse(json['time']),
      temperature2m: getDouble(json['temperature_2m']),
      rain: getDouble(json['rain']),
      showers: getDouble(json['showers']),
      snowfall: getDouble(json['snowfall']),
      cloudCover: getDouble(json['cloud_cover']),
      cloudCoverLow: getDouble(json['cloud_cover_low']),
      cloudCoverMid: getDouble(json['cloud_cover_mid']),
      cloudCoverHigh: getDouble(json['cloud_cover_high']),
    );
  }
}

Future<List<WeatherData>> fetchWeatherData() async {
  final url = Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=45.5088&longitude=-73.5878&current=temperature_2m,relative_humidity_2m,is_day,precipitation,rain,showers,snowfall,cloud_cover,wind_speed_10m&hourly=temperature_2m,rain,showers,snowfall,cloud_cover,cloud_cover_low,cloud_cover_mid,cloud_cover_high&timezone=America%2FNew_York');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    try {
      final decodedData = json.decode(response.body);
      final hourlyData = decodedData['hourly'];
      List<WeatherData> weatherDataList = [];

      for (int i = 0; i < hourlyData['time'].length; i++) {
        weatherDataList.add(WeatherData(
          time: DateTime.parse(hourlyData['time'][i]),
          temperature2m: hourlyData['temperature_2m'][i].toDouble(),
          rain: hourlyData['rain'][i].toDouble(),
          showers: hourlyData['showers'][i].toDouble(),
          snowfall: hourlyData['snowfall'][i].toDouble(),
          cloudCover: hourlyData['cloud_cover'][i].toDouble(),
          cloudCoverLow: hourlyData['cloud_cover_low'][i].toDouble(),
          cloudCoverMid: hourlyData['cloud_cover_mid'][i].toDouble(),
          cloudCoverHigh: hourlyData['cloud_cover_high'][i].toDouble(),
        ));
      }

      return weatherDataList;
    } catch (e) {
      print('Error occurred while parsing weather data: $e');
      return [];
    }
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Failed to load weather data');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<List<WeatherData>> futureWeatherData;

  @override
  void initState() {
    super.initState();
    futureWeatherData = fetchWeatherData();  // Implement this function based on your API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300], // Change this to match your design color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _buildLocationRow(), // You'll define this below
              Spacer(),
              FutureBuilder<List<WeatherData>>(
                future: futureWeatherData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return _buildWeatherInfo(snapshot.data!); // You'll define this below
                  } else {
                    return Text('No weather data available');
                  }
                },
              ),
              Spacer(),
              _buildHourlyForecast(), // You'll define this below
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationRow() {
    // Placeholder for location row
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Mumbai', style: TextStyle(color: Colors.white, fontSize: 24.0)),
        Icon(Icons.keyboard_arrow_down, color: Colors.white),
      ],
    );
  }

  Widget _buildWeatherInfo(List<WeatherData> data) {
    // Placeholder for main weather info
    return Column(
      children: <Widget>[
        Text('${data.temperature2m.toStringAsFixed(1)}°', style: TextStyle(fontSize: 80, color: Colors.white, fontWeight: FontWeight.bold)),
        Text(data.weatherCondition, style: TextStyle(color: Colors.white, fontSize: 24.0)),
        Text(DateFormat('EEEE, MMMM d').format(data.time), style: TextStyle(color: Colors.white, fontSize: 16.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Icons and data for wind, humidity, etc.
          ],
        )
      ],
    );
  }

  Widget _buildHourlyForecast() {
    // Placeholder for hourly forecast
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 24, // Placeholder for hourly forecast count
        itemBuilder: (context, index) {
          // Placeholder for hourly weather data
          return Card(
            color: Colors.blue[600],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text('00:00', style: TextStyle(color: Colors.white)),
                  Icon(Icons.cloud, color: Colors.white),
                  Text('27°', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}