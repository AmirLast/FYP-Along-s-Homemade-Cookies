import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_textfield.dart';

class ForgorPassword extends StatefulWidget {
  const ForgorPassword({super.key});

  @override
  State<ForgorPassword> createState() => _ForgorPasswordState();
}

class _ForgorPasswordState extends State<ForgorPassword> {
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
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                  'Your password reset link is sent to your email. Check in email to proceed'),
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          image: DecorationImage(
            image: const AssetImage("lib/images/applogo.png"),
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.surface.withOpacity(0.2),
              BlendMode.dstATop,
            ),
            alignment: Alignment.center,
            scale: 0.5,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              //title of current widget
              Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      Text(
                        "Insert E-mail to reset password",
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.primary,
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
                        obscureText: false,
                        isEnabled: true,
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
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
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
      ),
    );
  }
}
