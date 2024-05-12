import 'package:flutter/material.dart';
import 'package:fyp/components/my_button.dart';
import 'package:fyp/pages/loginpage.dart';
import 'package:fyp/pages/registerpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool popListener() {
    //so kalau user tekan back, bagitau, dia akan exit app
    return (showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to close the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: popListener,
      child: Scaffold(
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
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage())),
            ),
          ],
        ),
      ),
    );
  }
}
