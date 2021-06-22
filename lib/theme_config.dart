import 'package:flutter/material.dart';

class ThemeConfig {
  ThemeConfig({
    required this.font,
    required this.primaryColor,
    required this.isDark,
  });

  final String font;
  final Color primaryColor;
  final bool isDark;

  ThemeConfig copyWith({
    String? font,
    Color? primaryColor,
    bool? isDark,
  }) =>
      ThemeConfig(
        font: font ?? this.font,
        primaryColor: primaryColor ?? this.primaryColor,
        isDark: isDark ?? this.isDark,
      );

  factory ThemeConfig.fromJson(Map<String, dynamic> json) => ThemeConfig(
        font: json["font"],
        primaryColor: Color(json["primaryColor"]),
        isDark: json["isDark"],
      );

  Map<String, dynamic> toJson() => {
        "font": font,
        "primaryColor": primaryColor.value,
        "isDark": isDark,
      };
}
