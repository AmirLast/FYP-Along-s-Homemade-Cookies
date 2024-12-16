import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/components/my_textfield.dart';

class ForgorPassword extends StatefulWidget {
  const ForgorPassword({super.key});

  @override
  State<ForgorPassword> createState() => _ForgorPasswordState();
}

class _ForgorPasswordState extends State<ForgorPassword> {
  //for logo
  final Logo show = Logo();
  TextEditingController emailController = TextEditingController();

  final url =
      'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyAFgdksbfVdVQ1OM46UcxO-40ScjkNT8ng'; //web api key to sent reset password/verify email/change email - email

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPass() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Your password reset link is sent to your email. Check in email to proceed'),
            ); //pop up to UI so user know what error it is
          });
    } on FirebaseAuthException catch (e) {
      //  print(e); //for console
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            ); //pop up to UI so user know what error it is
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffd1a271),
      body: Container(
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight, //max height for current phone
        decoration: show.showLogo(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            //title of current widget
            const Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 48,
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
                      "Insert E-mail to reset password",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),

                    const SizedBox(height: 60),

                    //email
                    MyTextField(
                      controller: emailController,
                      caps: TextCapitalization.none,
                      inputType: TextInputType.emailAddress,
                      labelText: "Email",
                      hintText: "",
                      obscureText: false,
                      isEnabled: true,
                      isShowhint: false,
                    ),

                    const SizedBox(height: 60),

                    MaterialButton(
                      onPressed: () {
                        resetPass();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                              fontSize: 20,
                            ),
                          ),
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
}
