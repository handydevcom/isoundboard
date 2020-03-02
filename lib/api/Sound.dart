import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isoundboard/app/SoundsApp.dart';
import 'package:isoundboard/app/StorageHelper.dart';

class Sound {
  DocumentReference reference;

  String id;
  String path;

  String name;
  String storage;

  List<dynamic> liked;
  int likedCount;

  Sound(this.name, this.storage, this.liked, this.likedCount);

  String getAppPath() {
    if (path.endsWith('mp3')) {
      return '$path';
    } else {
      return '$path.mp3';
    }
  }

  String getName() {
    return name != null ? name : 'NULL';
  }

  Future<String> getAppFullPath() async {
    return getFilePath(getAppPath());
  }

  Future<bool> isDownloaded() async {
    return await isFileExist(getAppPath());
  }

  bool isLiked() {
    var result = false;
    if (firebaseUser != null) {
      liked.forEach((item) {
        if (item as String == firebaseUser.uid) {
          result = true;
        }
      });
    }
    return result;
  }

  void setLiked(bool value) {
    if (firebaseUser != null) {
      var newList = <String>[];
      liked.forEach((item) {
        newList.add(item);
      });
      if (value) {
        newList.add(firebaseUser.uid);
      } else {
        newList.remove(firebaseUser.uid);
      }
      liked = newList;
    }
  }

  static Sound fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Sound result = Sound.fromJson(snapshot.data);
    result.id = snapshot.documentID;
    result.path = snapshot.reference.path;
    result.reference = snapshot.reference;
    return result;
  }

  Sound.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        storage = json['storage'],
        liked = json['liked'],
        likedCount = json['likedCount'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'storage': storage,
        'liked': liked,
        'likedCount': likedCount
      };
}
