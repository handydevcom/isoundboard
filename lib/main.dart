import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/SoundsApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkTheme = prefs.getBool('keyIsDarkTheme') ?? false;
  runApp(SoundsApp.getThemedInstance(isDarkTheme));
}
