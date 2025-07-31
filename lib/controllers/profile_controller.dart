import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_uploader/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    if (authController.user == null) {
      print("Error: Current user is null, cannot get user data.");
      return;
    }

    List<String> thumbnails = [];
    var myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (var doc in myVideos.docs) {
      thumbnails.add(doc.data()['thumbnail']);
    }

    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();

    if (!userDoc.exists) {
      Get.snackbar('Error', 'User profile not found.');
      return;
    }

    final userData = userDoc.data() as Map<String, dynamic>;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];

    var followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();
    int followers = followerDoc.docs.length;
    int following = followingDoc.docs.length;

    int likes = 0;

    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List? ?? []).length;
    }

    var isFollowingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();
    bool isFollowing = isFollowingDoc.exists;

    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'posts': myVideos.docs.length.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
      'videos':
          myVideos.docs.map((doc) => doc.data()['videoUrl'] as String).toList(),
    };
    update();
  }

  followUser() async {
    if (authController.user == null) {
      print("Error: Current user is null, cannot follow.");
      return;
    }

    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value
          .update('followers', (value) => (int.parse(value) + 1).toString());
    } else {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value
          .update('followers', (value) => (int.parse(value) - 1).toString());
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
