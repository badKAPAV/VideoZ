import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_uploader/constants.dart';
import 'package:video_uploader/models/user.dart';

class SearchingController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);
  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typeUser) async {
    _searchedUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typeUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];
      for (var element in query.docs) {
        retVal.add(User.fromSnap(element));
      }
      return retVal;
    }));
  }
}
