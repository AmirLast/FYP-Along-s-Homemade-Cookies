import 'package:flutter/material.dart';
import 'package:fyp/pages/all_user/loginpage.dart';
import 'package:fyp/pages/all_user/registerpage.dart';

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
      backgroundColor: const Color(0xffd1a271),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //name of app
          const Center(
            child: Text(
              "Along's\nHomemade\nCookies",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'BlackMango',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 15),

          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Color(0xffd1a271),
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
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 100),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          //register
          MaterialButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage())),
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 100),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
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
