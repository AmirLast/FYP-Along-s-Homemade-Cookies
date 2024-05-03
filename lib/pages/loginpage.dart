import 'package:flutter/material.dart';
import 'package:fyp/components/my_button.dart';
import 'package:fyp/components/my_textfield.dart';
import 'package:fyp/pages/homepage2.dart';
import 'package:fyp/pages/registerpage.dart';
import 'package:fyp/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // login user
  void login() async {
    //authenticating
    final _authService = AuthService();

    //try sign in
    try {
      await _authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
    }

    //display error
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }

    //done -> to homepage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage2(),
      ),
    );
  }

  //forgot password
  void forgotPw() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("User tapped forgot password."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //title of current widget
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: 32,
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
                      "Insert Email and Password",
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 60),

                    //email
                    MyTextField(
                      controller: emailController,
                      labelText: "Email",
                      obscureText: false,
                    ),

                    const SizedBox(height: 30),

                    //password
                    MyTextField(
                      controller: passwordController,
                      labelText: "Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 60),

                    //sign in button
                    MyButton(
                      text: "Sign In",
                      onTap: login,
                    ),

                    const SizedBox(height: 25),

                    //register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have no account?",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterPage())), //goto Register
                          child: Text(
                            "Click here to Register",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // const SizedBox(width: 4),
                        // GestureDetector(
                        //   onTap: () => Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               ForgotPW())), //goto Register
                        //   child: Text(
                        //     "Forgot Password? Click here",
                        //     style: TextStyle(
                        //       color: Theme.of(context).colorScheme.secondary,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                      ],
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
