import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String keyIsDarkTheme = 'keyIsDarkTheme';

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

Future<bool> isDarkThemePref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(keyIsDarkTheme) ?? false;
}

Future<void> setIsDarkThemePref(bool enabled) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(keyIsDarkTheme, enabled);
}
