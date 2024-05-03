import 'package:flutter/material.dart';
import 'package:fyp/components/my_button.dart';
import 'package:fyp/pages/loginpage.dart';
import 'package:fyp/pages/registerpage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //name of app
          Center(
            child: Text(
              "Along's\nHomemade\nCookies",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 25),

          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.background,
              BlendMode.color,
            ),
            child: Image.asset(
              "lib/images/applogo.png",
              height: 250,
            ),
          ),

          const SizedBox(height: 30),

          //sign in button
          MyButton(
            text: "Sign In",
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage())),
          ),

          const SizedBox(height: 10),

          //register
          MyButton(
            text: "Sign Up",
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage())),
          ),
        ],
      ),
    );
  }
}
