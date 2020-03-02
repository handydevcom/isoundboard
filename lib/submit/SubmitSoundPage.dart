import 'package:flutter/material.dart';

class SubmitSoundPage extends StatefulWidget {
  @override
  SubmitSoundPageState createState() => SubmitSoundPageState();
}

class SubmitSoundPageState extends State<SubmitSoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            'SubmitSoundPage',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
