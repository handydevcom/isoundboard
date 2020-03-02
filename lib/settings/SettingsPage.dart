import 'package:flutter/material.dart';
import '../app/SoundsApp.dart';
import '../app/AppHelper.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();

    isDarkThemePref().then((value) {
      setState(() {
        isDarkTheme = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Тёмная тема',
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: isDarkTheme,
                  onChanged: (value) {
                    setState(() {
                      isDarkTheme = !isDarkTheme;
                      SoundsApp.getThemedInstance(false).setIsDarkMode(value);
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
