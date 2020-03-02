import 'dart:math';

import 'package:isoundboard/api/Sound.dart';

class SoundCategory {
  int id;
  String name;
  List<Sound> sounds;

  SoundCategory({this.id, this.name}) {
    int count = new Random().nextInt(10);
    sounds = new List();
    for (int i = 0; i < count; i++) {}
  }
}
