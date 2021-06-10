part of 'model.dart';

enum provider {
  AF,
  AL,
  DZ,
  AS,
  AD,
  AO,
  AI,
  AQ,
  AG,
  AR,
  AM,
  AW,
  AU,
  AT,
  AZ,
  BS,
  BH
}

class Weather {
  final weatherStatus;
  final weatherDescription;
  final temp;
  final humid;
  final min_temp;
  final max_temp;
  final windSpeed;
  final windDegree;
  final city;
  final icon;
  final id;

  Weather(
      this.id,
      this.weatherStatus,
      this.weatherDescription,
      this.temp,
      this.humid,
      this.min_temp,
      this.max_temp,
      this.windSpeed,
      this.windDegree,
      this.city,
      this.icon);

  factory Weather.fromJson(Map<dynamic, dynamic> weatherData) {
    return Weather(
        weatherData['weather'][0]['id'],
        weatherData['weather'][0]['main'],
        weatherData['weather'][0]['description'],
        weatherData['main']['temp'],
        weatherData['main']['humidity'],
        weatherData['main']['temp_min'],
        weatherData['main']['temp_max'],
        weatherData['wind']['speed'],
        weatherData['wind']['deg'],
        weatherData['name'],
        weatherData['weather'][0]['icon']);
  }
}
