import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

//api key = 38f1edd443f7c53cc9d5694620f187f9
//api call = https://api.openweathermap.org/data/3.0/onecall?lat=45.51&lon=-73.56&units=metric&appid=38f1edd443f7c53cc9d5694620f187f9
class WeatherInfo {
  final String imageUrl;
  final String description;

  WeatherInfo({required this.imageUrl, required this.description});
}

class CurrentWeather {
  final DateTime time;
  final double temperature;
  final int weatherCode;
  final bool isDay;
  final double precipitation;
  final int cloudCover;
  final double windSpeed;

  CurrentWeather({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.isDay,
    required this.precipitation,
    required this.cloudCover,
    required this.windSpeed,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: DateTime.parse(json['time']),
      temperature: json['temperature_2m'].toDouble(),
      weatherCode: json['weather_code'],
      isDay: json['is_day'] == 1,
      precipitation: json['precipitation'].toDouble(),
      cloudCover: json['cloud_cover'],
      windSpeed: json['wind_speed_10m'].toDouble(),
    );
  }
}

Future<CurrentWeather> fetchCurrentWeather() async {
  final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=45.5088&longitude=-73.5878&current=temperature_2m,is_day,precipitation,weather_code,cloud_cover,wind_speed_10m&hourly=temperature_2m,weather_code&timezone=America%2FNew_York');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final currentWeatherJson = jsonResponse['current'];
    return CurrentWeather.fromJson(currentWeatherJson);
  } else {
    throw Exception('Failed to load current weather data');
  }
}

class HourlyWeather {
  final DateTime time;
  final double temperature;
  final int weatherCode;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.weatherCode,
  });

  Future<Map<String, dynamic>> loadWeatherData() async {
    final jsonString = await rootBundle.loadString('assets/weatherIcon.json');
    return json.decode(jsonString);
  }

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: DateTime.parse(json['time']),
      temperature: json['temperature_2m'].toDouble(),
      weatherCode: json['weather_code'],
    );
  }
}

Future<List<HourlyWeather>> fetchHourlyWeather() async {
  final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=45.5088&longitude=-73.5878&current=temperature_2m,is_day,precipitation,weather_code,cloud_cover,wind_speed_10m&hourly=temperature_2m,weather_code&timezone=America%2FNew_York');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    if (data.containsKey('hourly') && data['hourly'] != null) {
      List<dynamic> times = data['hourly']['time'];
      List<dynamic> temperatures = data['hourly']['temperature_2m'];
      List<dynamic> weatherCodes = data['hourly']['weather_code'];

      List<HourlyWeather> hourlyForecasts = [];
      for (int i = 0; i < times.length; i++) {
        hourlyForecasts.add(HourlyWeather.fromJson({
          'time': times[i],
          'temperature_2m': temperatures[i],
          'weather_code': weatherCodes[i],
        }));
      }
      return hourlyForecasts;
    } else {
      throw Exception('Hourly data not available in the response');
    }
  } else {
    throw Exception(
        'Failed to load hourly weather data with status code: ${response.statusCode}');
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
      home: FutureBuilder(
        future: fetchWeatherData(),
        builder: (context, AsyncSnapshot<WeatherData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              return WeatherScreen(
                currentWeather: snapshot.data!.currentWeather,
                hourlyForecast: snapshot.data!.hourlyWeather,
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Future<WeatherData> fetchWeatherData() async {
  CurrentWeather currentWeather = await fetchCurrentWeather();
  List<HourlyWeather> hourlyWeather = await fetchHourlyWeather();
  return WeatherData(
      currentWeather: currentWeather, hourlyWeather: hourlyWeather);
}

class WeatherData {
  final CurrentWeather currentWeather;
  final List<HourlyWeather> hourlyWeather;

  WeatherData({required this.currentWeather, required this.hourlyWeather});
}

class WeatherScreen extends StatelessWidget {
  final CurrentWeather currentWeather;
  final List<HourlyWeather> hourlyForecast;

  WeatherScreen({required this.currentWeather, required this.hourlyForecast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: _buildCurrentWeather(currentWeather),
          ),
          Expanded(
            flex: 2,
            child: _buildHourlyForecast(hourlyForecast),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentWeather(CurrentWeather weather) {
    return FutureBuilder<WeatherInfo>(
      future: weather.getWeatherData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(snapshot.data!.imageUrl),
                  Text(
                    '${weather.temperature.toInt()}°',
                    style: TextStyle(fontSize: 100, color: Colors.white),
                  ),
                  Text(
                    snapshot.data!.description,
                    // Consider using snapshot data for description too
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    DateFormat('EEEE, MMMM d').format(weather.time),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.air, color: Colors.white),
                      Text('${weather.windSpeed}km/h',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 16), // Space between items
                      Icon(Icons.opacity, color: Colors.white),
                      Text('${weather.precipitation}%',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(width: 16), // Space between items
                      Icon(Icons.cloud, color: Colors.white),
                      Text('${weather.cloudCover}%',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Text("Error loading weather icon.");
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildHourlyForecast(List<HourlyWeather> forecast) {
    return Container(
      height: 120, // Fixed height for the hourly forecast list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final hourlyWeather = forecast[index];
          return Container(
            width: 80,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade400, // Match card color to the image
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('ha').format(hourlyWeather.time),
                  style: TextStyle(color: Colors.white),
                ),
                // Assuming you have a default weather icon
                Icon(
                  Icons.wb_sunny,
                  color: Colors.white,
                ),
                Text(
                  '${hourlyWeather.temperature.toInt()}°',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
