import 'package:dynamic_theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

import 'theme/theme_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ThemeBloc()..add(InitializeThemeEvent()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: state.data,
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _fontController = TextEditingController();
  final _colorController = CircleColorPickerController();
  bool isDark = false;

  bool afterInitialize = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildForm(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ThemeBloc>(context).add(
            UpdateThemeEvent(
              ThemeConfig(
                font: _fontController.text,
                primaryColor: _colorController.color,
                isDark: isDark,
              ),
            ),
          );
        },
        tooltip: 'Save',
        child: Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildForm() {
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (!afterInitialize) {
          setState(() {
            _fontController.text = state.config.font;
            _colorController.color = state.config.primaryColor;
            isDark = state.config.isDark;
          });

          setState(() {
            afterInitialize = true;
          });
        }
      },
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: CircleColorPicker(
              controller: _colorController,
              size: const Size(240, 240),
              strokeWidth: 4,
              thumbSize: 36,
              onChanged: (color) {
                setState(() {
                  _colorController.color = color;
                });
              },
            ),
          ),
          Text('Font Family'),
          TextField(
            controller: _fontController,
            decoration: InputDecoration(hintText: 'Font Family'),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text('Dark Mode: '),
              Switch(
                  value: isDark,
                  onChanged: (newValue) {
                    setState(() {
                      isDark = newValue;
                    });
                  })
            ],
          ),
        ],
      ),
    );
  }
}
