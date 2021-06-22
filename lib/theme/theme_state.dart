part of 'theme_bloc.dart';

@immutable
class ThemeState {
  final ThemeConfig config;
  final ThemeData data;

  ThemeState({required this.data, required this.config});

  factory ThemeState.initial() {
    final _initialConfig = ThemeConfig(
      font: 'Roboto',
      primaryColor: Colors.pink,
      isDark: true,
    );

    return ThemeState(
      data: BaseTheme(_initialConfig).toTheme,
      config: _initialConfig,
    );
  }
}
