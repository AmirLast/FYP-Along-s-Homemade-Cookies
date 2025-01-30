import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_drawer.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/models/userlistclass.dart';
import 'package:fyp/pages/admin/functions/updateuserlist.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final Logo show = Logo(); //for logo
  final load = Loading();
  final scaffoldOBJ = MyScaffoldmessage(); //for scaffold message
  final obj = UpdateUserList();
  List<UserList> users = UserList.user.users;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffd1a271),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "User List",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.more_vert,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width, //max width for current phone
            height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
            decoration: show.showLogo(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                users.isEmpty
                    ? const Expanded(
                        child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text("Users not found.."),
                      ))
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: users.length,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          users[index].name,
                                          style: const TextStyle(color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Center(
                                          child: Text(
                                            users[index].type,
                                            style: const TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Center(
                                          child: Text(
                                            users[index].shop,
                                            style: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: SizedBox(
                                          width: 50,
                                          child: Text(
                                            users[index].ban ? "Banned" : "-",
                                            style: TextStyle(color: users[index].ban ? Colors.red : Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                                    child: Text(
                                      users[index].ban ? "Unban" : "Ban",
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: Text(
                                          users[index].ban ? "Unban " + users[index].name + " ?" : "Ban " + users[index].name + " ?",
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                iconSize: 50,
                                                color: Colors.green,
                                                onPressed: () async {
                                                  load.loading(context);
                                                  await FirebaseFirestore.instance.collection('users').doc(users[index].uid).update({
                                                    "ban": !users[index].ban,
                                                  }).then((on) async {
                                                    String banText = "";
                                                    if (users[index].ban) {
                                                      banText = "unbanned";
                                                    } else {
                                                      banText = "banned";
                                                    }
                                                    obj.updateUserList(context).then((x) {
                                                      setState(() {
                                                        scaffoldOBJ.scaffoldmessage(users[index].name + " has been " + banText, context);
                                                      });
                                                    });
                                                  });
                                                },
                                                icon: const Icon(Icons.check_circle),
                                              ),
                                              IconButton(
                                                  iconSize: 50,
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.cancel)),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
