import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_taste/components/my_text_fields.dart';
import 'package:local_taste/components/big_button.dart';
import 'package:local_taste/utils/theme_colors.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //textEditing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //checkbox to show password
  bool showPassword = false;

  //sign user in
  Future<void> signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException {
      // show error message
      showErrorMessage("Wrong Email or Password");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor().lightColors.shade100,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: AppColor().lightColors.shade900,
                  width: 3.0,
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Error!',
                    style: TextStyle(
                      color: AppColor().lightColors.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    message,
                    style: TextStyle(
                      color: AppColor().lightColors.shade800,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: AppColor().lightColors.shade100,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor().lightColors.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().lightColors.shade500,
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //image
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/login.png'),
                        ),
                      ),
                    ),
                  ),
                  //Welcome
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: AppColor().lightColors.shade100,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Discover unique flavors of your city with us.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor().lightColors.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //EmailTextField
                  MyTextField(
                      controller_: emailController,
                      hintText: 'Email',
                      obscureText: false),
                  //PasswordTextField
                  MyTextField(
                    controller_: passwordController,
                    hintText: 'Password',
                    obscureText: !showPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColor().lightColors.shade800,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword =
                              !showPassword; // Toggle the showPassword flag
                        });
                      },
                    ),
                  ),
                  //forgot Password
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ForgotPasswordPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: AppColor().lightColors.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //signIn Button
                  BigButton(
                    buttonText: 'Sign In',
                    onTap: signUserIn,
                  ),
                  //register now
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35,
                      bottom: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(
                            color: AppColor().lightColors.shade100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            ' Register Now',
                            style: TextStyle(
                              color: AppColor().lightColors.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
