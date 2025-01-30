import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/models/userlistclass.dart';
import 'package:fyp/pages/admin/userlistpage.dart';

class UpdateUserList {
  final load = Loading();
  List<UserList> x = [];
  updateUserList(context) async {
    UserList.user.users.clear();
    try {
      load.loading(context);
      await FirebaseFirestore.instance.collection('users').where("type", isNotEqualTo: "admin").get().then((qSs) {
        for (var dSs in qSs.docs) {
          UserList.user = UserList(
            name: dSs.get('fullname'),
            uid: dSs.id,
            type: dSs.get('type'),
            ban: dSs.get('ban'),
          );
          if (UserList.user.type == "seller") {
            UserList.user.shop = dSs.get('shop');
          } else {
            UserList.user.shop = "none";
          }
          x.add(UserList.user);
        }
        UserList.user.users = x;
      }).then((onValue) {
        Navigator.pop(context); //pop loading
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const UserListPage()), ModalRoute.withName("/"));
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
