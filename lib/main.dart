import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherstation/screens/user_dashboard.dart';
import 'package:weatherstation/theme/theme_provider.dart';

import 'controllers/weather_provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserDashBoard(),
      title: 'Weather Station',
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
