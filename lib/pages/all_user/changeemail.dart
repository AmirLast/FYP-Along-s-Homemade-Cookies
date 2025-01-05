import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/components/general/my_textfield.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final show = Logo();
  final scaffoldOBJ = MyScaffoldmessage(); //for scaffold message
  final load = Loading();
  //texteditingcontroller
  late TextEditingController emailC;
  late TextEditingController passC;
  //visibility
  late bool passCV;

  @override
  void initState() {
    super.initState();
    emailC = TextEditingController();
    passC = TextEditingController();
    passCV = false;
  }

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passC.dispose();
  }

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
            "Change Email",
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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
          decoration: show.showLogo(),
          child: Column(
            children: [
              const SizedBox(height: 120),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "Fill in the information",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),

                    //email
                    MyTextField(
                      maxLength: 0,
                      controller: emailC,
                      caps: TextCapitalization.none,
                      inputType: TextInputType.emailAddress,
                      labelText: "New Email",
                      hintText: "",
                      obscureText: false,
                      isEnabled: true,
                      isShowhint: false,
                    ),

                    const SizedBox(height: 30),

                    //current password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        cursorColor: Colors.black,
                        autofocus: false,
                        enabled: true,
                        controller: passC,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !passCV, //initially false = hide
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.shade400)),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passCV = !passCV;
                              });
                            },
                            icon: Icon(passCV ? Icons.visibility : Icons.visibility_off),
                            color: Colors.black,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade400,
                          labelText: "Current Password",
                          floatingLabelStyle: const TextStyle(color: Colors.black),
                          floatingLabelBehavior: null,
                          hintText: "",
                          hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.4)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),
                    MaterialButton(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                        margin: const EdgeInsets.symmetric(horizontal: 85),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Updates",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (emailC.text == "") {
                          scaffoldOBJ.scaffoldmessage("Email is blank", context);
                        } else if (passC.text == "") {
                          scaffoldOBJ.scaffoldmessage("Password is blank", context);
                        } else {
                          // loading circle-----
                          load.loading(context);
                          //--------------------
                          try {
                            final user = FirebaseAuth.instance.currentUser;
                            await user?.verifyBeforeUpdateEmail(emailC.text).then((onValue) async {
                              await FirebaseAuth.instance.signOut().then((onValue) async {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(email: emailC.text, password: passC.text)
                                    .then((onValue) async {
                                  await user.unlink("google.com").then((onValue) async {
                                    final cred = EmailAuthProvider.credential(email: emailC.text, password: passC.text);
                                    user.linkWithCredential(cred).then((onValue) {
                                      Navigator.pop(context);
                                      scaffoldOBJ.scaffoldmessage("Email successfully changed", context);
                                    });
                                  });
                                });
                              });
                            });
                          } on FirebaseException catch (e) {
                            Navigator.pop(context);
                            scaffoldOBJ.scaffoldmessage("Email fail to change", context);
                            if (kDebugMode) {
                              print(e.code.toString());
                            }
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
