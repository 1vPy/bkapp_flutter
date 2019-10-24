//Created by 1vPy on 2019/10/24.
import 'package:flutter/material.dart';

class ThemeUtil {

  static ThemeUtil instance = ThemeUtil.internal();

  Map<String, Color> darkTheme = new Map();
  Map<String, Color> lightTheme = new Map();

  ThemeUtil.internal() {
    darkTheme['canvasColor'] = Color(0xFF303030);
    lightTheme['canvasColor'] = Colors.white;
    darkTheme['tabColor'] = Color(0xFF303030);
    lightTheme['tabColor'] = Colors.white70;
    darkTheme['movieItemColor'] = Colors.blueGrey;
    lightTheme['movieItemColor'] = Colors.white70;
  }
}
