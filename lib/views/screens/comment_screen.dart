import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_uploader/constants.dart';
import 'package:video_uploader/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({super.key, required this.id});

  final TextEditingController _commentController = TextEditingController();

  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                /* const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                      child: Text(
                    'Comments',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ), */
                Expanded(child: Obx(() {
                  return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage:
                                  NetworkImage(comment.profilePhoto),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  comment.username,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  comment.comment,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  tago.format(comment.datePublished.toDate()),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${comment.likes.length} likes',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: InkWell(
                                onTap: () =>
                                    commentController.likeComment(comment.id),
                                child: Icon(
                                  comment.likes.contains(authController.user.uid)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: comment.likes
                                          .contains(authController.user.uid)
                                      ? Colors.red
                                      : Colors.white,
                                  size: 18,
                                ),
                              ),
                            ));
                      });
                })),
                // const Divider(),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ListTile(
                      title: TextFormField(
                        controller: _commentController,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Add a comment',
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                      trailing: TextButton(
                          onPressed: () => commentController
                              .postComment(_commentController.text.trim()),
                          child: const Text(
                            'Send',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ),
                //const SizedBox(height: 50,)
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      controller: _commentController,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Comment',
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                    TextButton(
                      onPressed: () => commentController
                          .postComment(_commentController.text.trim()),
                      child: const Text(
                        'Send',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ) */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
