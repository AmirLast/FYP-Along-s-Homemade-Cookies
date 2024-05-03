import 'package:flutter/material.dart';
import 'package:fyp/pages/loginpage.dart';
import 'package:fyp/services/auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void register() async {
    // get auth service
    final _authService = AuthService();

    // check if password match
    if (passwordController.text == confirmpasswordController.text) {
      //create user
      try {
        await _authService.signUpWithEmailPassword(
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

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match!"),
        ),
      );
    }
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
              "Sign Up",
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
                      "Fill in the information",
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 60),

                    //username

                    //phone number

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

                    const SizedBox(height: 30),

                    //confirm password
                    MyTextField(
                      controller: confirmpasswordController,
                      labelText: "Confirm Password",
                      obscureText: true,
                    ),

                    const SizedBox(height: 60),

                    //sign up button
                    MyButton(
                      text: "Sign Up",
                      onTap: register,
                    ),

                    const SizedBox(height: 25),

                    //to login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage())),
                          child: Text(
                            "Click here to Login",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
