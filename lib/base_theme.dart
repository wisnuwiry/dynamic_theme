import 'package:dynamic_theme/theme_config.dart';
import 'package:flutter/material.dart';

class BaseTheme {
  final ThemeConfig? config;

  BaseTheme(this.config);

  ThemeData get toTheme {
    return ThemeData(
      primaryColor: config?.primaryColor,
      fontFamily: config?.font,
      brightness:
          (config?.isDark ?? false) ? Brightness.dark : Brightness.light,
    );
  }
}
