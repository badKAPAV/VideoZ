import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_uploader/constants.dart';
import 'package:video_uploader/models/user.dart' as model;
import 'package:video_uploader/views/screens/home_screen.dart';
import 'package:video_uploader/views/screens/auth/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;

  late Rx<File?> _pickedImage;

  final isLoading = false.obs;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _pickedImage = Rx<File?>(null);
    _user.bindStream(firebaseAuth.authStateChanges());
    _setInitialScreen(_user.value);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      Get.snackbar('Profile Picture', 'Profile picture selected successfully');
      _pickedImage.value = File(pickedImageFile.path);
    }
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        isLoading.value = true;
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
            name: username,
            profilePhoto: downloadUrl,
            email: email,
            uid: cred.user!.uid);

        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        Get.snackbar('Success', 'Account created successfully');
        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar(
          'Error creating account',
          'Please enter all fields and select a profile picture',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        isLoading.value = true;
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Get.snackbar("Success", "Signed in successfully");

        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar("Error signing in", "Please enter all fields");
      }
    } catch (e) {
      Get.snackbar("Error signing in", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void signOut() async {
    try {
      await firebaseAuth.signOut();

      Get.offAll(() => LoginScreen());
    } catch (e) {
      Get.snackbar('Error signing out', e.toString());
    }
  }
}
