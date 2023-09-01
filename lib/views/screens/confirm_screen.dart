import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_uploader/controllers/upload_video_controller.dart';
import 'package:video_uploader/views/widgets/text_input_field.dart';

class ConfirmScreen extends StatefulWidget {

  final File videoFile;

  final String videoPath;

  const ConfirmScreen({super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;

  final TextEditingController _songController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController= TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  UploadVideoController uploadVideoController = Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(height: 30,),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width-20,
                    child: TextInputField(controller: _songController, labelText: 'Song Name', icon: Icons.music_note),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width-20,
                    child: TextInputField(controller: _titleController, labelText: 'Title', icon: Icons.title),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width-20,
                    child: TextInputField(controller: _descriptionController, labelText: 'Description', icon: Icons.description),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width-20,
                    child: TextInputField(controller: _categoryController, labelText: 'Category', icon: Icons.category),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed: () => uploadVideoController.uploadVideo(_songController.text.trim(), _titleController.text.trim(), _descriptionController.text.trim(), _categoryController.text.trim(), widget.videoPath), child: const Text('Post Now', style: TextStyle(fontSize: 20, color: Colors.white),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}