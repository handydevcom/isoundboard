import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  @override
  SupportPageState createState() => SupportPageState();
}

class SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Помощь'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Упс. Что-то пошло не так. Во всём виноват разработчик. Сообщите ему о проблеме в группе ВКонтакте.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            FlatButton(
              child: Text(
                'Сообщить о проблеме',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
              onPressed: () {
                launch('https://vk.com/topic-191247382_40392616');
              },
            )
          ],
        ),
      ),
    );
  }
}
