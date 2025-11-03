import 'package:flutter/material.dart';

const colorList = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.orange,
  Colors.purple,
  Colors.black,
];

class AppTheme {
  final int selectedColor;

  AppTheme({
    this.selectedColor = 0
  }):assert(selectedColor >= 0, 'selectedColor must be grater than 0'),
    assert(selectedColor < colorList.length, 
    'selectedColor must be less than ${colorList.length - 1}');

  ThemeData getTheme() =>ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList[selectedColor],
    appBarTheme: const AppBarTheme(
      centerTitle: true
    )
  );
}
