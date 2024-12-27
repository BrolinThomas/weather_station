import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _weatherData;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get weatherData => _weatherData;

  Future<void> fetchWeather(String cityName) async {
    if (cityName.isEmpty) {
      _errorMessage = "City name cannot be empty.";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    _weatherData = null;
    notifyListeners();

    const apiKey = '86666cddd625e7cdd81533161bba41e2';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _weatherData = json.decode(response.body);
      } else {
        _errorMessage = "City not found or invalid city name.";
      }
    } catch (e) {
      _errorMessage = "Failed to fetch weather data. Check your connection.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
