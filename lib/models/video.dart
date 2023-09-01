import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String title;
  String description;
  String category;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.title,
    required this.description,
    required this.category,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "songName": songName,
        "title": title,
        "description": description,
        "category": category,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
        "profilePhoto": profilePhoto,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
        username: snapshot['username'],
        uid: snapshot['uid'],
        id: snapshot['id'],
        likes: snapshot['likes'],
        commentCount: snapshot['commentCount'],
        shareCount: snapshot['shareCount'],
        songName: snapshot['songName'],
        title: snapshot['title'],
        description: snapshot['description'],
        category: snapshot['category'],
        videoUrl: snapshot['videoUrl'],
        thumbnail: snapshot['thumbnail'],
        profilePhoto: snapshot['profilePhoto']);
  }
}
