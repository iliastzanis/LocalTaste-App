import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/big_button.dart';
import '../../components/my_text_fields.dart';
import '../../utils/theme_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showMessage("Success!", "Password reset link sent! Check your Email");
    } on FirebaseAuthException catch (e) {
      print(e);
      showMessage("Error!", "Wrong Email");
    }
  }

  // Show successfull message after email sent style
  void showMessage(String title, String message) {
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
                    title,
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
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter your Email and we will send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //EmailTextField
          MyTextField(
            controller_: emailController,
            hintText: 'Email',
            obscureText: false,
          ),
          SizedBox(
            height: 10,
          ),
          //Send Button
          BigButton(
            buttonText: 'Reset Password',
            onTap: passwordReset,
          ),
        ],
      ),
    );
  }
}
