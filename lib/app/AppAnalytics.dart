import 'package:isoundboard/api/Sound.dart';
import 'package:isoundboard/app/SoundsApp.dart';

Future<void> onSoundDownloadingEvent(Sound sound) async =>
    await sendAnalyticsEvent(
        'sound_downloading', <String, dynamic>{'path': sound.path});

Future<void> onSoundDownloadedEvent(Sound sound) async =>
    await sendAnalyticsEvent(
        'sound_downloaded', <String, dynamic>{'path': sound.path});

Future<void> onSoundDownloadErrorEvent(Sound sound, String error) async =>
    await sendAnalyticsEvent('sound_download_error',
        <String, dynamic>{'path': sound.path, 'error': error});

Future<void> onSoundPlayingEvent(Sound sound) async => await sendAnalyticsEvent(
    'sound_playing', <String, dynamic>{'path': sound.path});

Future<void> onLikeClickedEvent(Sound sound) async => await sendAnalyticsEvent(
    'like_clicked', <String, dynamic>{'path': sound.path});

Future<void> onDislikeClickedEvent(Sound sound) async =>
    await sendAnalyticsEvent(
        'dislike_clicked', <String, dynamic>{'path': sound.path});

Future<void> sendAnalyticsEvent(
        String name, Map<String, dynamic> params) async =>
    await firebaseAnalytics.logEvent(name: name, parameters: params);
