import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:isoundboard/app/SoundsApp.dart';
import '../api/Channel.dart';

Widget buildChannelItem(Channel channel, bool big) {
  double imageSize = big ? 50 : 35;
  double titleSize = big ? 28 : 20;
  double subtitleSize = big ? 18 : 12;
  double space = big ? 16 : 8;

  return Hero(
    tag: channel.id,
    transitionOnUserGestures: false,
    child: Material(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          channel.image.isEmpty
              ? Icon(
                  Icons.play_arrow,
                  size: imageSize,
                )
              : Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(channel.image),
                          fit: BoxFit.cover),
                      borderRadius:
                          BorderRadius.all(Radius.circular(imageSize / 2)),
                      border: Border.all(
                          color: SoundsApp.getInstance().getCurrentTintColor(),
                          width: 0.4)),
                ),
          SizedBox(width: space),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                channel.title,
                maxLines: 1,
                minFontSize: 0.0,
                style:
                    TextStyle(fontSize: titleSize, fontWeight: FontWeight.w600),
              ),
              Opacity(
                opacity: 0.5,
                child: AutoSizeText(
                  channel.description,
                  maxLines: 1,
                  minFontSize: 0,
                  style: TextStyle(
                      fontSize: subtitleSize, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          )),
        ],
      ),
    ),
  );
}
