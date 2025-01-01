import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/components/general/my_textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final show = Logo();
  final scaffoldOBJ = MyScaffoldmessage(); //for scaffold message
  final load = Loading();
  //texteditingcontroller
  late TextEditingController emailC;
  late TextEditingController passC;
  late TextEditingController newpassC;
  late TextEditingController newpass2C;
  //password visibility
  late bool passCV;
  late bool newpassCV;
  late bool newpass2CV;

  @override
  void initState() {
    super.initState();
    emailC = TextEditingController();
    passC = TextEditingController();
    newpassC = TextEditingController();
    newpass2C = TextEditingController();
    passCV = false;
    newpassCV = false;
    newpass2CV = false;
  }

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passC.dispose();
    newpassC.dispose();
    newpass2C.dispose();
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
            "Change Password",
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
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
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
                    labelText: "Email",
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

                  const SizedBox(height: 30),

                  //new password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      cursorColor: Colors.black,
                      autofocus: false,
                      enabled: true,
                      controller: newpassC,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !newpassCV, //initially false
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
                              newpassCV = !newpassCV;
                            });
                          },
                          icon: Icon(newpassCV ? Icons.visibility : Icons.visibility_off),
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade400,
                        labelText: "New Password",
                        floatingLabelStyle: const TextStyle(color: Colors.black),
                        floatingLabelBehavior: null,
                        hintText: "",
                        hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.4)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  //new password confirm
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      cursorColor: Colors.black,
                      autofocus: false,
                      enabled: true, //get this value
                      controller: newpass2C,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !newpass2CV, //initially false
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
                              newpass2CV = !newpass2CV;
                            });
                          },
                          icon: Icon(newpass2CV ? Icons.visibility : Icons.visibility_off),
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade400,
                        labelText: "Re-input New Password",
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
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 85),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Save Changes",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      var isError = false; //for error boolean
                      String error = ""; //the error description

                      //checking errors
                      if (emailC.text == "") {
                        error = "Email is blank";
                        isError = true;
                      } else if (passC.text == "") {
                        error = "Current password is blank";
                        isError = true;
                      } else if (newpassC.text == "") {
                        error = "New password is blank";
                        isError = true;
                      } else if (newpass2C.text == "") {
                        error = "Re-input password is blank";
                        isError = true;
                      } else if (newpassC.text != newpass2C.text) {
                        error = "New password is not same";
                        isError = true;
                      }

                      //if there is error, show it and don't sign up
                      if (isError) {
                        isError = false;
                        scaffoldOBJ.scaffoldmessage(error, context);
                        return;
                      } else {
                        // loading circle-----
                        load.loading(context);
                        //--------------------
                        try {
                          final user = FirebaseAuth.instance.currentUser;
                          final cred = EmailAuthProvider.credential(email: emailC.text, password: passC.text);

                          user?.reauthenticateWithCredential(cred).then((value) {
                            user.updatePassword(newpassC.text).then((_) {
                              scaffoldOBJ.scaffoldmessage("Password Updated", context);
                            }).catchError((error) {
                              Navigator.pop(context);
                              scaffoldOBJ.scaffoldmessage("Fail to update password", context);
                            });
                          }).catchError((err) {
                            Navigator.pop(context);
                            scaffoldOBJ.scaffoldmessage("Fail to update password", context);
                          }).then((onValue) {
                            Navigator.pop(context);
                            setState(() {
                              emailC = TextEditingController();
                              passC = TextEditingController();
                              newpassC = TextEditingController();
                              newpass2C = TextEditingController();
                            });
                          });
                        } on FirebaseException catch (e) {
                          Navigator.pop(context);
                          scaffoldOBJ.scaffoldmessage("Fail to update password", context);
                          if (kDebugMode) {
                            print(e.code.toString());
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
