import 'package:flutter/material.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //name of app
          Center(
            child: Text(
              "Along's\nHomemade\nCookies",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'BlackMango',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 15),

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
          MaterialButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage())),
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 100),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          //register
          MaterialButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterPage())),
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 100),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
