import 'package:cloud_firestore/cloud_firestore.dart';

class Channel {
  String id;

  String title;
  String description;
  String category;
  String image;

  Channel(this.title, this.description, this.category, this.image);

  static Channel fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Channel result = Channel.fromJson(snapshot.data);
    result.id = snapshot.documentID;
    return result;
  }

  bool isValid() {
    return title != null &&
        description != null &&
        category != null &&
        image != null;
  }

  Channel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        category = json['category'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'category': category,
        'image': image
      };
}
