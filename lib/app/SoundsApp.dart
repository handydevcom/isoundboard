import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:isoundboard/channels/ChannelsPage.dart';

import 'AppHelper.dart';

FirebaseAnalytics firebaseAnalytics;
FirebaseAuth firebaseAuth;
FirebaseStorage firebaseStorage;
FirebaseUser firebaseUser;

bool isDarkTheme;
SoundsAppState appState;
bool isOffline;

class SoundsApp extends StatefulWidget {
  SoundsApp(bool darkTheme) {
    isDarkTheme = darkTheme;
    FlutterCrashlytics().initialize();
    firebaseAnalytics = FirebaseAnalytics();
    FirebaseAuth.instance.signInAnonymously().then((result) {
      firebaseUser = result.user;
    });
    firebaseAuth = FirebaseAuth.instance;
    firebaseStorage = FirebaseStorage(
        app: FirebaseApp.instance,
        storageBucket: 'gs://papich-375b1.appspot.com');
  }

  static SoundsApp instance;
  static SoundsApp getThemedInstance(bool isDarkTheme) {
    if (instance == null) {
      instance = SoundsApp(isDarkTheme);
    }
    return instance;
  }

  static SoundsApp getInstance() => getThemedInstance(isDarkTheme);

  Color getCurrentTintColor() =>
      appState.isDarkTheme ? Colors.white : Colors.black;

  @override
  SoundsAppState createState() {
    appState = SoundsAppState(isDarkTheme);
    return appState;
  }

  void setIsDarkMode(bool isDarkTheme) {
    if (appState != null) {
      appState.setIsDarkTheme(isDarkTheme);
      setIsDarkThemePref(isDarkTheme);
    }
  }
}

const appColor = Color.fromARGB(255, 15, 190, 124);

const cursorColor = Colors.white;

final primaryColorLight = Colors.grey[400];
final primaryColorDark = Colors.grey[800];

const accentColor = Colors.black;
const accentColorDark = Colors.grey;

class SoundsAppState extends State<SoundsApp> {
  bool isDarkTheme;
  SoundsAppState(this.isDarkTheme);

  StreamSubscription<ConnectivityResult> connectivitySubscription;

  void setIsDarkTheme(bool isDarkTheme) {
    setState(() {
      this.isDarkTheme = isDarkTheme;
    });
  }

  Color getPrimaryColor() => isDarkTheme ? primaryColorDark : primaryColorLight;
  Color getAccentColor() => isDarkTheme ? accentColorDark : accentColor;

  Color getLightColor() => isDarkTheme ? primaryColorDark : primaryColorLight;
  Color getDarkColor() => isDarkTheme ? primaryColorLight : primaryColorDark;

  @override
  void initState() {
    super.initState();
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      isOffline = result == ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: firebaseAnalytics),
      ],
      theme: ThemeData(
          brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          fontFamily: 'MarkerFelt',
          cursorColor: cursorColor,
          cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: cursorColor,
          ),
          primaryColor: isDarkTheme ? null : Colors.grey,
          primaryColorLight: getLightColor(),
          primaryColorDark: getDarkColor(),
          primarySwatch: Colors.red,
          buttonColor: Colors.red,
          accentColor: isDarkTheme ? accentColorDark : accentColor,
          appBarTheme: isDarkTheme
              ? null
              : AppBarTheme(
                  color: Colors.white,
                ),
          snackBarTheme: SnackBarThemeData(
              contentTextStyle: TextStyle(fontFamily: 'MarkerFelt'))),
      home: ChannelsPage(),
    );
  }
}
