import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/models/memberclass.dart';
import 'package:fyp/models/userclass.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  bool isMember = UserNow.usernow.isMember;
  int point = Member.member.memPoint;
  final Logo show = Logo(); //for logo
  final load = Loading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      appBar: AppBar(
        backgroundColor: const Color(0xffB67F5F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            "Membership",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
        decoration: show.showLogo(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Container(
                width: 150,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text("Membership Benefit")),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                          child: Text(
                            "- For every RM1 purchase = +1 Point",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                          child: Text(
                            "- New member first purchase +100 Point",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !isMember
                      ? MaterialButton(
                          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                          padding: const EdgeInsets.all(10),
                          color: Colors.green,
                          textColor: Colors.black,
                          child: const Text("Join Member"),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                content: const Text(
                                  "Confirm joining member?",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        iconSize: 50,
                                        color: Colors.green,
                                        icon: const Icon(Icons.check_circle),
                                        onPressed: () async {
                                          load.loading(context);
                                          await FirebaseFirestore.instance.collection('users').doc(UserNow.usernow.user?.uid).update({
                                            "ismember": true,
                                          }).then((onValue) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            UserNow.usernow.isMember = true;
                                            Member.member.memPoint = 0;
                                            setState(() {
                                              isMember = UserNow.usernow.isMember;
                                              point = Member.member.memPoint;
                                            });
                                          });
                                        },
                                      ),
                                      IconButton(
                                        iconSize: 50,
                                        color: Colors.red,
                                        onPressed: () => Navigator.pop(context),
                                        icon: const Icon(Icons.cancel),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : MaterialButton(
                          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                          padding: const EdgeInsets.all(10),
                          color: Colors.green,
                          textColor: Colors.black,
                          child: Text("Current Point: $point"),
                          onPressed: () {},
                        ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
