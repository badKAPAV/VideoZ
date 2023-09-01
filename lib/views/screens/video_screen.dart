import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_uploader/constants.dart';
import 'package:video_uploader/controllers/video_controller.dart';
import 'package:video_uploader/views/screens/comment_screen.dart';
import 'package:video_uploader/views/widgets/video_player_item.dart';

import '../widgets/circle_animation.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(colors: [Colors.grey, Colors.white]),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: data.videoUrl),
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 20, bottom: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  data.username,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  data.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white.withOpacity(.3),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical:5, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.music_note,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 2,),
                                          Text(
                                            data.songName,
                                            style: const TextStyle(
                                                fontSize: 15, color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white.withOpacity(.3),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical:5, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.category,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 2,),
                                          Text(
                                            data.category,
                                            style: const TextStyle(
                                                fontSize: 15, color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: size.height / 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildProfile(data.profilePhoto),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () => videoController.likeVideo(data.id),
                                    child: Icon(
                                      data.likes.contains(authController.user.uid)? Icons.favorite: Icons.favorite_border,
                                      color: data.likes.contains(authController.user.uid)?Colors.red : Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data.likes.length.toString(),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentScreen(id: data.id,))),
                                    child: const Icon(
                                      Icons.comment,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data.commentCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data.shareCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              CircleAnimation(
                                child: buildMusicAlbum(data.profilePhoto),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                    )
                  ],
                )
              ],
            );
          },
        );
      }),
    );
  }
}
