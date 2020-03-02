import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isoundboard/api/Channel.dart';
import 'package:isoundboard/app/AppHelper.dart';
import 'package:isoundboard/app/SoundsApp.dart';
import 'package:isoundboard/channel/ChannelPage.dart';
import 'package:isoundboard/widgets/AppWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ChannelsPage extends StatefulWidget {
  @override
  ChannelsPageState createState() {
    return ChannelsPageState();
  }
}

class ChannelsPageState extends State<ChannelsPage> {
  ScrollController controller;

  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();

    isDarkThemePref().then((value) {
      isDarkTheme = value;
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iSoundboard'),
        actions: <Widget>[
          Container(
            width: 60,
            child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Image.asset(
                    'images/vk.png',
                    color: SoundsApp.getInstance().getCurrentTintColor(),
                  ),
                ),
                onTap: () => launch('https://vk.com/public191247382')),
          ),
          Container(
            width: 60,
            child: InkWell(
              child: Icon(Icons.remove_red_eye),
              onTap: () {
                setState(() {
                  isDarkTheme = !isDarkTheme;
                  SoundsApp.getInstance().setIsDarkMode(isDarkTheme);
                });
              },
            ),
          )
        ],
      ),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('channels').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: new Text('Загрузка...'));
            default:
              return new ListView(
                children: snapshot.data.documents
                    .map((DocumentSnapshot documentSnapshot) {
                  Channel channel =
                      Channel.fromDocumentSnapshot(documentSnapshot);
                  if (channel.isValid()) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          buildContext,
                          MaterialPageRoute(
                              builder: (context) => ChannelPage(channel)),
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.all(16),
                          child: buildChannelItem(channel, true)),
                    );
                  } else {
                    return Container(
                      color: Colors.red,
                      child: Text('${channel.toJson()}'),
                    );
                  }
                }).toList(),
              );
          }
        },
      )),
    );
  }
}
