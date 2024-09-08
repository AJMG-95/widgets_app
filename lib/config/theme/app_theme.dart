import 'package:flutter/material.dart';

const colorList = <Color>[
  Color(0xFF001F3F),
  Color(0xFF0074D9),
  Color(0xFF2ECC40),
  Color(0xFF3D9970),
  Color(0xFFFFDC00),
  Color(0xFFFF851B),
  Color(0xFFFF4136),
  Color(0xFFAAAAAA),
  Color(0xFFFFFFFF),
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false
    }): assert(selectedColor >= 0, 'Selected color must be grater than 0'),
        assert(selectedColor < colorList.length , 'Selected color must be less or equal than ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[selectedColor],
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    )
  );
}
