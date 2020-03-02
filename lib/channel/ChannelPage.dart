import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isoundboard/api/Channel.dart';
import 'package:isoundboard/api/Sound.dart';
import 'package:isoundboard/app/AppPlayer.dart';
import 'package:isoundboard/widgets/AppWidgets.dart';
import 'package:isoundboard/widgets/SoundItem.dart';

bool isPaused = false;

class ChannelPage extends StatefulWidget {
  final Channel channel;
  ChannelPage(this.channel);

  @override
  ChannelPageState createState() {
    return ChannelPageState(channel);
  }
}

class ChannelPageState extends State<ChannelPage> with WidgetsBindingObserver {
  Channel channel;
  ChannelPageState(this.channel);

  ScrollController controller;
  bool isNotificationsEnabled = false;
  bool isSubscriptionEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    AppPlayer.getInstance().stop();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    isPaused = state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive;
    if (isPaused) {
      AppPlayer.getInstance().stop();
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[Expanded(child: buildChannelItem(channel, false))],
      )),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('channels/${channel.id}/sounds')
            .orderBy('likedCount', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: new Text('Загрузка...'));
            default:
              return new ListView.separated(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  final Sound s = Sound.fromDocumentSnapshot(
                      snapshot.data.documents[index]);
                  return SoundItem(s);
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  indent: 0.0,
                  endIndent: 0.0,
                  height: 0.0,
                ),
              );
          }
        },
      )),
      /*
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: _dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          FabActionButton(
              value: true,
              textOn: 'Загрузить',
              textOff: null,
              iconOn: Icon(Icons.file_upload),
              iconOff: null,
              onClick: () {
                //todo share
              }),
          FabActionButton(
              value: true,
              textOn: 'Поделиться',
              textOff: null,
              iconOn: Icon(Icons.share),
              iconOff: null,
              onClick: () {
                //todo share
              }),
          FabActionButton(
              value: isNotificationsEnabled,
              textOn: 'Выключить уведомления',
              textOff: 'Включить уведомления',
              iconOn: Icon(Icons.notifications_off),
              iconOff: Icon(Icons.notifications_active),
              onClick: () {
                setState(() {
                  isNotificationsEnabled = !isNotificationsEnabled;
                });
              }),
          FabActionButton(
              value: isSubscriptionEnabled,
              textOn: 'Отменить подписку',
              textOff: 'Подписаться',
              iconOn: Icon(Icons.delete),
              iconOff: Icon(Icons.subscriptions),
              onClick: () {
                setState(() {
                  isSubscriptionEnabled = !isSubscriptionEnabled;
                });
              }),
          SpeedDialChild(
            child: Icon(Icons.search),
            label: 'Поиск',
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
            onTap: () {},
          ),
        ],
      ),

       */
    );
  }
}
