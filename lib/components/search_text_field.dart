import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../utils/theme_colors.dart';

class SearchTextField extends StatelessWidget {
  final controller_;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;

  const SearchTextField({
    super.key,
    required this.controller_,
    required this.hintText,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor().lightColors.shade100.withOpacity(0.6),
            border: Border.all(
              color: AppColor().lightColors.shade900.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(35)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            controller: controller_,
            inputFormatters:
                inputFormatters, // Assign the inputFormatters to the TextField
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColor()
                    .lightColors
                    .shade900
                    .withOpacity(0.6), // Customize the color of the hint text
              ),
            ),
          ),
        ),
      ),
    );
  }
}
