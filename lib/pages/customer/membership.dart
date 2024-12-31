import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/models/memberclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/customer/userhomepage.dart';

class MembershipPage extends StatefulWidget {
  final String pop;
  const MembershipPage({super.key, required this.pop});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  bool isMember = UserNow.usernow.isMember;
  int point = Member.member.memPoint;
  final Logo show = Logo(); //for logo
  final load = Loading();
  List<String> benefits = [
    "Every 100 point = RM1 redeemable for price reduction",
    "For every RM1 purchase = +1 Point",
    "New member first purchase = +100 Point",
    "For first RM10 x5 purchase = +300 Point",
    "For first RM30 purchase = +500 Point",
  ];

  void toPop() {
    if (widget.pop == "pop") {
      Navigator.pop(context);
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const UserHomePage(), settings: const RouteSettings(name: "/")),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        toPop;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffd1a271),
        appBar: AppBar(
          backgroundColor: const Color(0xffB67F5F),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: toPop,
          ),
          title: const Center(
            child: Text(
              textAlign: TextAlign.center,
              "Membership",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: benefits.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                              child: Text(
                                benefits[index],
                                style: const TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ),
                        );
                      },
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
                                            }).then((a) async {
                                              await FirebaseFirestore.instance.collection('members').add({
                                                'id': UserNow.usernow.user?.uid,
                                                'firstPurch': true,
                                                'memPoint': 0,
                                                'rm10x5Purch': 0,
                                                'rm30Purch': true,
                                              });
                                            }).then((onValue) {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              UserNow.usernow.isMember = true;
                                              Member.member = Member(memPoint: 0, firstPurch: true, rm30Purch: true, rm10x5Purch: 0);
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
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                padding: const EdgeInsets.all(10),
                                color: Colors.green,
                                textColor: Colors.black,
                                child: Text("Current Point: $point"),
                                onPressed: () {},
                              ),
                              const SizedBox(width: 15),
                              MaterialButton(
                                shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                padding: const EdgeInsets.all(10),
                                color: Colors.green,
                                textColor: Colors.black,
                                child: const Text("Check Available Benefit"),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5.0),
                                            child: Text(
                                              "List Benefits",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Member.member.firstPurch
                                                    ? const Icon(Icons.check_box_outline_blank_rounded, color: Colors.black, size: 30)
                                                    : const Icon(Icons.check_box_outlined, color: Colors.black, size: 30),
                                                const Expanded(
                                                  child: Text(
                                                    "First Purchase (100 Points)",
                                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Member.member.rm10x5Purch < 5
                                                    ? const Icon(Icons.check_box_outline_blank_rounded, color: Colors.black, size: 30)
                                                    : const Icon(Icons.check_box_outlined, color: Colors.black, size: 30),
                                                const Expanded(
                                                  child: Text(
                                                    "First RM10 x5 Purchase (300 Points)",
                                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Member.member.rm30Purch
                                                    ? const Icon(Icons.check_box_outline_blank_rounded, color: Colors.black, size: 30)
                                                    : const Icon(Icons.check_box_outlined, color: Colors.black, size: 30),
                                                const Expanded(
                                                  child: Text(
                                                    "First RM30 Purchase (500 Points)",
                                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
