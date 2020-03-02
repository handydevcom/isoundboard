import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:isoundboard/api/API.dart';
import 'package:isoundboard/api/Sound.dart';
import 'package:isoundboard/app/AppAnalytics.dart';
import 'package:isoundboard/app/AppPlayer.dart';
import 'package:isoundboard/app/SnackBars.dart';
import 'package:isoundboard/app/SoundsApp.dart';
import 'package:isoundboard/app/StorageDownloadResult.dart';
import 'package:isoundboard/app/StorageHelper.dart';
import 'package:isoundboard/channel/ChannelPage.dart';

class SoundItem extends StatefulWidget {
  final Sound sound;
  SoundItem(this.sound);

  @override
  SoundItemState createState() {
    return SoundItemState(sound);
  }
}

class SoundItemState extends State<SoundItem>
    with SingleTickerProviderStateMixin {
  static Sound lastClickedSound;

  Sound sound;
  bool enabled = false;

  SoundItemState(this.sound);

  double playingProgress = 0.0;
  bool downloading = false;
  bool downloaded = false;

  @override
  void initState() {
    sound.isDownloaded().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        downloaded = value;
      });
    });
    super.initState();
  }

  void playSound(Sound sound, bool forceStopped) async {
    String path = await sound.getAppFullPath();
    AppPlayer.getInstance().playSound(path, forceStopped, (percent) {
      if (!mounted) {
        return;
      }

      setState(() {
        playingProgress = percent;
      });
    });
  }

  double itemHeight = 70;

  Future<void> onPlayPauseClicked() async {
    lastClickedSound = sound;
    bool forceStopped = await AppPlayer.getInstance().stop();

    if (!mounted) {
      return;
    }

    if (await sound.isDownloaded()) {
      print('Playing file: ${sound.getAppPath()}');
      playSound(sound, forceStopped);
      onSoundPlayingEvent(sound);
    } else {
      print('Downloading file: ${sound.getAppPath()}');
      onSoundDownloadingEvent(sound);

      setState(() {
        downloading = true;
      });

      StorageDownloadResult result =
          await downloadFile(sound.getAppPath(), sound.storage);

      setState(() {
        downloaded = true;
        downloading = false;
      });

      if (result.isSuccess) {
        showSoundDownloadedSnackBar(context, sound.name);
        onSoundDownloadedEvent(sound);
        if (sound.id == lastClickedSound.id && !isPaused) {
          playSound(sound, forceStopped);
        }
      } else {
        showSoundDownloadErrorSnackBar(context, result.displayError);
        onSoundDownloadErrorEvent(sound, result.displayError);
      }
    }
  }

  bool executingLikeApi = false;
  bool lastLikeValue;

  void onLikeClicked() async {
    if (!mounted) {
      return;
    }

    if (isOffline) {
      showNoInternetSnackBar(context);
      return;
    }

    bool newValue = !sound.isLiked();
    lastLikeValue = newValue;
    setState(() {
      sound.setLiked(newValue);
    });

    print('onLikeClicked: $newValue');

    if (!executingLikeApi) {
      print('onLikeClicked: executing api');

      executingLikeApi = true;
      await apiSetSoundLiked(sound.path, newValue);
      executingLikeApi = false;

      if (newValue) {
        onLikeClickedEvent(sound);
      } else {
        onDislikeClickedEvent(sound);
      }

      if (lastLikeValue != newValue) {
        print('onLikeClicked: value changed');
        sound.setLiked(newValue);
        onLikeClicked();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!mounted) {
          return;
        }
        if (isOffline && !(await sound.isDownloaded())) {
          showNoInternetSnackBar(context);
          return;
        }
        await onPlayPauseClicked();
      },
      child: Container(
          height: itemHeight,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: itemHeight,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColorDark.withOpacity(0.1)),
                  value: downloading ? null : playingProgress,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Opacity(
                            opacity: downloaded ? 1.0 : 0.5,
                            child: AutoSizeText(
                              sound.getName(),
                              maxLines: 1,
                              minFontSize: 0.0,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: itemHeight,
                    height: itemHeight,
                    child: InkWell(
                        onTap: () {
                          onLikeClicked();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              sound.isLiked()
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 30,
                              color: sound.isLiked()
                                  ? Colors.red
                                  : Theme.of(context).primaryColorDark,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              '${sound.liked.length}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 12),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
