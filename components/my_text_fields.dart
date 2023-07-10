import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../utils/theme_colors.dart';

class MyTextField extends StatelessWidget {
  final controller_;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextField({
    super.key,
    required this.controller_,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor().lightColors.shade100,
            border: Border.all(
              color: AppColor().lightColors.shade800,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            controller: controller_,
            obscureText: obscureText,
            inputFormatters:
                inputFormatters, // Assign the inputFormatters to the TextField
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              suffixIcon: suffixIcon != null
                  ? Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      child: suffixIcon,
                      color: AppColor().lightColors.shade100,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
