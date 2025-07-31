import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_uploader/constants.dart';
import 'package:video_uploader/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);

    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ConfirmScreen(
                videoFile: File(video.path),
                videoPath: video.path,
              )));
      // Navigator.push(context, route)
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: const Row(
                    children: [
                      Icon(Icons.image),
                      SizedBox(
                        width: 6,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Gallery',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.camera, context),
                  child: const Row(
                    children: [
                      Icon(Icons.camera_alt),
                      SizedBox(
                        width: 6,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Camera',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionsDialog(context),
          child: Container(
            width: 190,
            height: 200,
            decoration: BoxDecoration(
                color: buttonColor, borderRadius: BorderRadius.circular(30)),
            child: const Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_rounded,
                  size: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Add a video',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
