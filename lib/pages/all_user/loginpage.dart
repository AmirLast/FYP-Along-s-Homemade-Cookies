import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/components/general/my_textfield.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/forgorpassword.dart';
import 'package:fyp/pages/all_user/registerpage.dart';
import 'package:fyp/pages/all_user/verifyemailpage.dart';
import 'package:fyp/services/auth/auth_service.dart';
import 'package:fyp/services/auth/checkpass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool passwordVisibility;
  final load = Loading();
  final Logo show = Logo(); //for logo
  // login user
  Future<User?> login({required String email, required String password, required BuildContext context}) async {
    //authenticating
    final _authService = AuthService();
    User? user;

    // loading circle
    load.loading(context);

    //try sign in
    await _authService.signInWithEmailPassword(
      email,
      password,
      context,
    );
    user = _authService.getCurrentUser();

    return user;
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffd1a271),
      body: Container(
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight, //max height for current phone
        decoration: show.showLogo(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 120),
            //title of current widget
            const Text(
              "Sign In",
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

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "Insert Email and Password",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    //email
                    MyTextField(
                      maxLength: 0,
                      controller: emailController,
                      caps: TextCapitalization.none,
                      inputType: TextInputType.emailAddress,
                      labelText: "Email",
                      hintText: "",
                      obscureText: false,
                      isEnabled: true,
                      isShowhint: false,
                    ),

                    const SizedBox(height: 30),

                    //password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        cursorColor: Colors.black,
                        autofocus: false,
                        enabled: true, //get this value
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !passwordVisibility, //initially false = hide
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey.shade400)),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                            icon: Icon(passwordVisibility ? Icons.visibility : Icons.visibility_off),
                            color: Colors.black,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade400,
                          labelText: "Password",
                          floatingLabelStyle: const TextStyle(color: Colors.black),
                          floatingLabelBehavior: null,
                          hintText: "",
                          hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.4)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    MaterialButton(
                      onPressed: () async {
                        User? user =
                            await login(email: emailController.text, password: passwordController.text, context: context); //dah login
                        //re-check password strength since user can reset password with weak password
                        final obj = PasswordStrength();
                        List passStrength = obj.checkpass(password: passwordController.text);
                        //all 4 criteria must qualify to be considered strength
                        bool isStrong = passStrength[0] && passStrength[1] && passStrength[2] && passStrength[3];
                        var dir = FirebaseFirestore.instance.collection('users');
                        await dir.doc(user!.uid).get().then((value) {
                          //these are general data loads for any user
                          UserNow.usernow = UserNow(
                            fullname: value.data()?['fullname'],
                            phone: value.data()?['phone'],
                            user: user,
                            type: value.data()?['type'],
                            currentdir: value.data()?['currentdir'],
                            passStrength: value.data()?['passStrength'],
                          );
                          //check user type
                          if (value.data()?['type'] != "admin") {
                            //for owner and user has address
                            UserNow.usernow.address = value.data()?['address'];
                            if (value.data()?['type'] == "owner") {
                              //for owner, they have extra data
                              UserNow.usernow.categories = value.data()?['categories'];
                              UserNow.usernow.shop = value.data()?['shop'];
                            }
                          }
                        });
                        //update password strength value
                        dir.doc(user.uid).update({
                          "passStrength": isStrong,
                        });
                        //make them verify first, verify page will handle diff user routing
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).pop();
                          // pop loading circle if success
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const VerifyEmailPage(),
                              settings: const RouteSettings(name: "/"),
                            ),
                            (r) => false,
                          );
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 85),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    InkWell(
                      child: const Text(
                        "Forgot password?",
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgorPassword()));
                      },
                    ),

                    const SizedBox(height: 25),

                    //register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have no account?",
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => const RegisterPage())), //goto Register
                          child: const Text(
                            "Click here to Register",
                            style: TextStyle(
                              color: Colors.black,
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
