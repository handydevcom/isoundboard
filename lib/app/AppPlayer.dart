// ignore: camel_case_types
import 'package:audioplayer/audioplayer.dart';

class AppPlayer {
  AudioPlayer audioPlayer;
  Function onUpdate;
  Function onComplete;
  String lastPath;

  AppPlayer() {
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print('Audio player state: $state');
      if (state == AudioPlayerState.COMPLETED ||
          state == AudioPlayerState.STOPPED) {
        onUpdate(0.0);
      }
    });
    audioPlayer.onAudioPositionChanged.listen((Duration d) {
      double percent = d.inMilliseconds / audioPlayer.duration.inMilliseconds;
      onUpdate(percent);
    });
  }

  Future<bool> stop() async {
    bool isStopped = false;
    if (audioPlayer.state == AudioPlayerState.PLAYING) {
      await audioPlayer.stop();
      isStopped = true;
    }
    return isStopped;
  }

  Future<void> playSound(
      String path, bool forceStopped, void onUpdate(double value)) async {
    if (forceStopped && path == lastPath) {
      return;
    }

    lastPath = path;
    this.onUpdate = onUpdate;
    await audioPlayer.play(path, isLocal: true);
  }

  static AppPlayer instance;
  static AppPlayer getInstance() {
    if (instance == null) {
      instance = AppPlayer();
    }
    return instance;
  }
}
