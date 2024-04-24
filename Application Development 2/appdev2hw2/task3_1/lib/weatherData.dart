class WeatherData {
  final double temperature;
  final String description;
  final String icon;
  final DateTime dateTime;
  final double windSpeed;
  final int humidity;
  final int clouds;
  List<HourlyForecast> hourlyForecasts;

  WeatherData({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.dateTime,
    required this.windSpeed,
    required this.humidity,
    required this.clouds,
    required this.hourlyForecasts,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final String apiKey = "2aacf9ce74f2491f9bb222655241904";
    return WeatherData(
      temperature: json['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      windSpeed: json['wind_speed'].toDouble(),
      humidity: json['humidity'],
      clouds: json['clouds'],
    );
  }
}
