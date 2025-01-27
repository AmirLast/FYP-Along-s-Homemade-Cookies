import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_drawer.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/models/userlistclass.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> with SingleTickerProviderStateMixin {
  final Logo show = Logo(); //for logo
  late List<UserList> users;
  final load = Loading();
  final scaffoldOBJ = MyScaffoldmessage(); //for scaffold message

  Future<void> updateUserList() async {
    try {
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
          users.add(UserList.user);
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    updateUserList();
  }

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
        body: Container(
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
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10.0),
                                padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
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
                                    Text(
                                      users[index].type,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      users[index].shop,
                                      style: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      users[index].ban ? "Banned" : "-",
                                      style: TextStyle(color: users[index].ban ? Colors.red : Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20),
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
                                                  await updateUserList().then((on) {
                                                    Navigator.pop(context); //pop dialog popup
                                                    Navigator.pop(context); //pop loading
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
    );
  }
}
