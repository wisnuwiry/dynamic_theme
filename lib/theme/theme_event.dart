part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class InitializeThemeEvent extends ThemeEvent {}

class UpdateThemeEvent extends ThemeEvent {
  final ThemeConfig config;

  UpdateThemeEvent(this.config);
}
