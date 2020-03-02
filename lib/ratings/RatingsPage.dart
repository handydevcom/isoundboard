import 'package:flutter/material.dart';

class RatingsPage extends StatefulWidget {
  @override
  RatingsPageState createState() => RatingsPageState();
}

class RatingsPageState extends State<RatingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            'RatingsPage',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
