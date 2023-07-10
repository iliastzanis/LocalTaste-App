import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_taste/components/my_text_fields.dart';
import 'package:local_taste/components/big_button.dart';
import 'package:local_taste/utils/theme_colors.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  SignUpPage({
    super.key,
    required this.onTap,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //textEditing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  //checkbox to show password 2 flags
  bool showPassword = false;
  bool showPassword2 = false;

  //sign user up
  Future<void> signUserUp() async {
    //try creating user
    try {
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.email)
            .set({
          'first name': firstNameController.text.trim(),
          'last name': lastNameController.text.trim(),
          'username': emailController.text.split('@')[0],
        });
      } else {
        showErrorMessage("Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      //show error message
      showErrorMessage(e.code.toString());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  //Error message
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
                  //Welcome
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Text(
                      'Register for LocalTaste',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: AppColor().lightColors.shade100,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 20),
                    child: Text(
                      'Let\'s create an account for you!',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor().lightColors.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //First Name TextField
                  MyTextField(
                      controller_: firstNameController,
                      hintText: 'First Name',
                      obscureText: false),
                  //Last Name TextField
                  MyTextField(
                      controller_: lastNameController,
                      hintText: 'Last Name',
                      obscureText: false),
                  //Email TextField
                  MyTextField(
                      controller_: emailController,
                      hintText: 'Email',
                      obscureText: false),
                  //Password TextField
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
                  //confirm Password
                  MyTextField(
                    controller_: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: !showPassword2,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword2 ? Icons.visibility : Icons.visibility_off,
                        color: AppColor().lightColors.shade800,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword2 =
                              !showPassword2; // Toggle the showPassword2 flag
                        });
                      },
                    ),
                  ),
                  //signIn Button
                  BigButton(
                    buttonText: 'Sign Up',
                    onTap: signUserUp,
                  ),
                  //register now
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member?',
                          style: TextStyle(
                            color: AppColor().lightColors.shade100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            ' Log In',
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
