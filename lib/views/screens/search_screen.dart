import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_uploader/controllers/search_controller.dart';
import 'package:video_uploader/models/user.dart';
import 'package:video_uploader/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchingController searchController = Get.put(SearchingController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          titleSpacing: 15,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0,),
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.white54,),
                  filled: false,
                  labelText: 'Search',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.white30),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                ),
                onFieldSubmitted: (value) => searchController.searchUser(value),
              ),
            ),
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ? const Center(
                child: Text(
                  'Search for users!',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white60,
                      fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(uid: user.uid))),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(user.profilePhoto),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }),
      );
    });
  }
}
