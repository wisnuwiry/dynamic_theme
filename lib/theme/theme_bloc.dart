import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dynamic_theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial());

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is InitializeThemeEvent) {
      yield* _mapInitializeThemeToState();
    } else if (event is UpdateThemeEvent) {
      yield* _mapUpdateThemeToState(event);
    }
  }

  Stream<ThemeState> _mapInitializeThemeToState() async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final rawThemeData = prefs.getString('theme');
      if (rawThemeData != null && rawThemeData is String) {
        final _config = ThemeConfig.fromJson(json.decode(rawThemeData));

        yield ThemeState(
          data: BaseTheme(_config).toTheme,
          config: _config,
        );
      }
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Stream<ThemeState> _mapUpdateThemeToState(UpdateThemeEvent event) async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('theme', json.encode(event.config.toJson()));

      add(InitializeThemeEvent());
    } catch (e) {
      print('ERROR: $e');
    }
  }
}
