import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_uploader/constants.dart';
import 'package:video_uploader/controllers/profile_controller.dart';
import 'package:video_uploader/views/screens/add_video_screen.dart';
import 'package:video_uploader/views/screens/profile_video_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  profileInfo(String type, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(type,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String video = '';
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddVideoScreen())),
                  icon: const Icon(Icons.add_box_outlined)),
              title: Center(
                child: Text(
                  controller.user['name'],
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.menu_rounded))
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: controller.user['profilePhoto'],
                            height: 100,
                            width: 100,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        profileInfo('Followers', controller.user['followers']),
                        const SizedBox(
                          width: 25,
                        ),
                        profileInfo('Following', controller.user['following']),
                        const SizedBox(
                          width: 25,
                        ),
                        profileInfo('Posts', controller.user['posts'])
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (widget.uid == authController.user.uid) {
                            authController.signOut();
                          } else {
                            controller.followUser();
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              // width: 120,
                              // height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    widget.uid == authController.user.uid
                                        ? 'Sign out'
                                        : controller.user['isFollowing']
                                            ? 'follow'
                                            : 'Follow',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    // video list here <--
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileVideoScreen(videoUrl: video))),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.user['thumbnails'].length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5),
                          itemBuilder: (context, index){
                            String thumbnail = controller.user['thumbnails'][index];
                            // String video = controller.user['videos'][index];
                            return CachedNetworkImage(imageUrl: thumbnail, fit: BoxFit.cover,);
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
