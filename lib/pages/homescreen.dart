import 'package:flutter/material.dart';
import 'package:fyp/components/my_menubutton.dart';
import 'package:fyp/pages/loginpage.dart';
import 'package:fyp/pages/registerpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //prevent back button will not be implemented until further new information

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
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
              Theme.of(context).colorScheme.surface,
              BlendMode.color,
            ),
            child: Image.asset(
              "lib/images/applogo.png",
              height: 250,
            ),
          ),

          const SizedBox(height: 30),

          //sign in button
          MyMenuButton(
            text: "Sign In",
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage())),
          ),

          const SizedBox(height: 10),

          //register
          MyMenuButton(
            text: "Sign Up",
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage())),
          ),
        ],
      ),
    );
  }
}
