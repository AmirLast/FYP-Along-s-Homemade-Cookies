import 'package:flutter/material.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/components/my_scaffoldmessage.dart';
import 'package:fyp/pages/all_user/loginpage.dart';
import 'package:fyp/pages/all_user/registerpage2.dart';
import 'package:fyp/services/auth/checkpass.dart';
import '../../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final MyScaffoldmessage scaffoldOBJ = MyScaffoldmessage(); //for scaffold message
  final Logo show = Logo(); //for logo
//text editing controller
  late TextEditingController confirmpasswordController;
  late TextEditingController emailController;
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late bool passwordVisibility; //for?
  late bool confirmpasswordVisibility; //for?
  late TextEditingController shopController;
  bool isOwner = false; //default value
  String type = "buyer"; //default value

  @override
  void initState() {
    super.initState();
    confirmpasswordController = TextEditingController();
    emailController = TextEditingController();
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    shopController = TextEditingController();
    passwordVisibility = false;
    confirmpasswordVisibility = false;
  }

  @override
  void dispose() {
    super.dispose();
    confirmpasswordController.dispose();
    emailController.dispose();
    fnameController.dispose();
    lnameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    shopController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      body: SingleChildScrollView(
        child: Container(
          decoration: show.showLogo(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60), //to replace safearea
              //title of current widget
              const Text(
                "Sign Up",
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
                          "Fill in the information",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),

                      //username
                      //first name
                      MyTextField(
                        controller: fnameController,
                        caps: TextCapitalization.words,
                        inputType: TextInputType.text,
                        labelText: "Firstname",
                        hintText: "",
                        obscureText: false,
                        isEnabled: true,
                        isShowhint: false,
                      ),

                      const SizedBox(height: 30),

                      //last name
                      MyTextField(
                        controller: lnameController,
                        caps: TextCapitalization.words,
                        inputType: TextInputType.text,
                        labelText: "Lastname",
                        hintText: "",
                        obscureText: false,
                        isEnabled: true,
                        isShowhint: false,
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Column(
                        children: [
                          RadioListTile(
                            activeColor: Colors.black,
                            title: const Text("Buyer"),
                            value: "buyer",
                            groupValue: type,
                            onChanged: (value) {
                              setState(() {
                                type = value.toString();
                                isOwner = false;
                                shopController.clear();
                              });
                            },
                          ),
                          RadioListTile(
                            activeColor: Colors.black,
                            title: const Text("Owner"),
                            value: "owner",
                            groupValue: type,
                            onChanged: (value) {
                              setState(() {
                                type = value.toString();
                                isOwner = true;
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      //shop name
                      MyTextField(
                        controller: shopController,
                        caps: TextCapitalization.words,
                        inputType: TextInputType.text,
                        labelText: "Shop Name",
                        hintText: "",
                        obscureText: false,
                        isEnabled: isOwner,
                        isShowhint: false,
                      ),

                      const SizedBox(height: 30),

                      //phone number
                      MyTextField(
                        controller: phoneController,
                        caps: TextCapitalization.none,
                        inputType: TextInputType.number,
                        labelText: "Phone Number",
                        hintText: "",
                        obscureText: false,
                        isEnabled: true,
                        isShowhint: false,
                      ),

                      const SizedBox(height: 30),

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
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      //confirm password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          cursorColor: Colors.black,
                          autofocus: false,
                          enabled: true, //get this value
                          controller: confirmpasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !confirmpasswordVisibility, //initially false
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
                                  confirmpasswordVisibility = !confirmpasswordVisibility;
                                });
                              },
                              icon: Icon(confirmpasswordVisibility ? Icons.visibility : Icons.visibility_off),
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade400,
                            labelText: "Confirm Password",
                            floatingLabelStyle: const TextStyle(color: Colors.black),
                            floatingLabelBehavior: null,
                            hintText: "",
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),

                      //sign up button
                      MaterialButton(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(horizontal: 85),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (passwordController.text != confirmpasswordController.text) {
                            scaffoldOBJ.scaffoldmessage('Passwords don\'t match!', context);
                            return;
                          }

                          //some value for error checking---------
                          var isBlank = false; //blank means no error
                          String error = ""; //the error description

                          //check password strength
                          List passStrength = [false, false, false, false]; //false for 4 category
                          //check password strength
                          final obj = PasswordStrength();
                          passStrength = obj.checkpass(password: passwordController.text);

                          //checking if it is blank or wrong length or password weak
                          if (fnameController.text == '') {
                            error = 'First name is blank';
                            isBlank = true;
                          } else if (lnameController.text == '') {
                            error = 'Last name is blank';
                            isBlank = true;
                          } else if (shopController.text == '' && isOwner) {
                            error = 'Shop name is blank';
                            isBlank = true;
                          } else if (emailController.text == '') {
                            error = 'Email is blank';
                            isBlank = true;
                          } else if (passwordController.text == '') {
                            error = 'Password is blank';
                            isBlank = true;
                          } else if (confirmpasswordController.text == '') {
                            error = 'Re-enter password is blank';
                            isBlank = true;
                          } else if (phoneController.text == '') {
                            error = 'Phone number is blank';
                            isBlank = true;
                          } else if (phoneController.text.length < 10) {
                            error = 'Phone number should be more than 10 numbers';
                            isBlank = true;
                          } else if (!passStrength[2]) {
                            error = 'Please add special character in password';
                            isBlank = true;
                          } else if (!passStrength[3]) {
                            error = 'Please add number in password';
                            isBlank = true;
                          } else if (passwordController.text.length < 10) {
                            error = 'Password should be at least 10 in length';
                            isBlank = true;
                          } else if (!(passStrength[0] && passStrength[1])) {
                            error = 'Password should combine lower and upper case';
                            isBlank = true;
                          }

                          //if there is error, show it and don't sign up
                          if (isBlank) {
                            isBlank = false;
                            scaffoldOBJ.scaffoldmessage(error, context);
                            return;
                          } else {
                            // loading circle-----
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(color: Color(0xffB67F5F)),
                                );
                              },
                            );
                            // loading circle-----
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.of(context).pop();
                              // pop loading circle
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Register2Page(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    fname: fnameController.text,
                                    lname: lnameController.text,
                                    type: type,
                                    shop: isOwner ? shopController.text : "",
                                    phone: phoneController.text,
                                    passStrength: true,
                                  ),
                                ),
                              );
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 25),

                      //to login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())),
                            child: const Text(
                              "Click here to Login",
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

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
