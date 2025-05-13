import 'package:flutter/material.dart';

final myTheme = ThemeData(
  primarySwatch: Colors.blue,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
);
