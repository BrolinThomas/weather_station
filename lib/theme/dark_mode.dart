import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    appBarTheme: const AppBarTheme(centerTitle: true),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: const Color.fromARGB(255,20,20,20),
      primary: const Color.fromARGB(255,105,105,105),
      secondary: const Color.fromARGB(255,30,30,30),
      tertiary: const Color.fromARGB(255,47,47,47),
      inversePrimary: Colors.grey.shade300
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.grey[300],
          displayColor: Colors.white,
        ));
