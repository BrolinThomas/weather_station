import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherstation/components/my_textfield.dart';
import '../components/my_drawer.dart';
import '../controllers/weather_provider.dart';

class UserDashBoard extends StatelessWidget {
  const UserDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final TextEditingController cityController = TextEditingController();
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Weather Station'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyTextField(
                onSuffixTap: () {
                  final cityName = cityController.text.trim();
                  weatherProvider.fetchWeather(cityName);
                },
                hintText: 'Enter your location',
                obscureText: false,
                controller: cityController),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            if (weatherProvider.isLoading) const CircularProgressIndicator(),
            if (weatherProvider.errorMessage != null)
              Text(
                weatherProvider.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            if (weatherProvider.weatherData != null)
              WeatherDetails(weatherData: weatherProvider.weatherData!),
          ],
        ),
      ),
    );
  }
}

class WeatherDetails extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherDetails({required this.weatherData, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weatherData['name'],
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.black26,
            height: 20,
          ),
          Row(
            children: [
              Icon(
                Icons.thermostat,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Temperature: ${weatherData['main']['temp']}°C',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.cloud,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Condition: ${weatherData['weather'][0]['description']}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.water_drop,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Humidity: ${weatherData['main']['humidity']}%',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}