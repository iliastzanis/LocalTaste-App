import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/theme_colors.dart';

class BigButton extends StatefulWidget {
  final String buttonText;
  final Function()? onTap;

  const BigButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  _BigButtonState createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
        Timer(Duration(milliseconds: 200), () {
          setState(() {
            isTapped = false;
          });
        });
      },
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor().lightColors.shade800,
            ),
            color: isTapped
                ? AppColor().lightColors.shade900
                : AppColor().lightColors.shade700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              widget.buttonText,
              style: TextStyle(
                color: AppColor().lightColors.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
