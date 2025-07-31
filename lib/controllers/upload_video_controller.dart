import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Using the modern, Dart 3 compatible version of video_compress
import 'package:video_compress/video_compress.dart';
import 'package:video_uploader/constants.dart';
import 'package:video_uploader/models/video.dart';

class UploadVideoController extends GetxController {
  final isLoading = false.obs;

  Future<void> _compressVideo(String videoPath) async {
    await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
    );
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    String uid = firebaseAuth.currentUser!.uid;
    Reference ref = firebaseStorage.ref().child('videos').child(uid).child(id);

    await _compressVideo(videoPath);

    final MediaInfo? info = await VideoCompress.getMediaInfo(videoPath);

    UploadTask uploadTask = ref.putFile(info!.file!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    String uid = firebaseAuth.currentUser!.uid;
    Reference ref =
        firebaseStorage.ref().child('thumbnails').child(uid).child(id);
    UploadTask uploadTask =
        ref.putFile(await VideoCompress.getFileThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songName, String title, String description,
      String category, String videoPath) async {
    try {
      isLoading.value = true;

      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        throw Exception("User document does not exist!");
      }

      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        title: title,
        description: description,
        category: category,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
      );

      await firestore.collection('videos').doc("Video $len").set(
            video.toJson(),
          );
      Get.snackbar('Upload successful', 'Video uploaded!');
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        'The operation failed. Please try a different video.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      print('Upload Error: $e');
    } finally {
      isLoading.value = false;
      await VideoCompress.deleteAllCache();
    }
  }
}
