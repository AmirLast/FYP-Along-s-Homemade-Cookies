import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pages/all_user/homescreen.dart';
import 'package:fyp/services/auth/userplacement.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    //user needs to be created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    // call after email verification
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified =
          FirebaseAuth.instance.currentUser!.emailVerified; //verified
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            e.toString(),
            style: TextStyle(color: Colors.grey.shade400),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const UserReplacement()
      : Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xffd1a271),
          body: Container(
            decoration: BoxDecoration(
              color: const Color(0xffd1a271),
              image: DecorationImage(
                image: const AssetImage("lib/images/applogo.png"),
                colorFilter: ColorFilter.mode(
                  const Color(0xffd1a271).withOpacity(0.2),
                  BlendMode.dstATop,
                ),
                alignment: Alignment.center,
                scale: 0.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //title of current widget
                const Text(
                  "Email Verification",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          "A verification email has been sent to your email",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 60),
                        ElevatedButton.icon(
                          onPressed:
                              canResendEmail ? sendVerificationEmail : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.all(25),
                          ),
                          icon: Icon(
                            Icons.email,
                            size: 32,
                            color: Colors.grey.shade400,
                          ),
                          label: Text(
                            "Resent Email",
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 60),
                        TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (r) => false,
                            );
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
