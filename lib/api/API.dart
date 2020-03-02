import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

const baseUrl = 'firebase-url';

Future<dynamic> apiSetSoundLiked(String path, bool liked) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return http
      .get('$baseUrl/setLiked?soundPath=$path&userId=${user.uid}&liked=$liked');
}
