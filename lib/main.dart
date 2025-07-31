import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:video_uploader/constants.dart';
import 'package:video_uploader/controllers/auth_controller.dart';
import 'package:video_uploader/firebase_options.dart';
import 'package:video_uploader/views/screens/auth/login_screen.dart';
// import 'package:video_uploader/views/screens/auth/login_screen.dart';
// import 'package:video_uploader/views/screens/auth/signup_screen.dart';
// import 'package:video_uploader/views/screens/home_screen.dart';
import 'package:video_uploader/views/screens/messages_screen.dart';
import 'package:video_uploader/views/screens/test_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Uploader',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: LoginScreen(),
    );
  }
}
