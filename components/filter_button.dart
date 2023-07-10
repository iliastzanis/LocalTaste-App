import 'package:flutter/material.dart';
import '../utils/theme_colors.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isActive;

  const FilterButton({
    required this.text,
    required this.onPressed,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = isActive
        ? AppColor().lightColors.shade500 // Active button color
        : AppColor().lightColors.shade50; // Inactive button color

    Color textColor = isActive
        ? AppColor().lightColors.shade100 // Active text color
        : AppColor()
            .lightColors
            .shade900
            .withOpacity(0.8); // Inactive text color

    Color borderColor = isActive
        ? AppColor()
            .lightColors
            .shade900
            .withOpacity(0.7) // Active border color
        : AppColor()
            .lightColors
            .shade900
            .withOpacity(0.6); // Inactive border color

    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.5, // Increase the border width for a bolder look
          ),
          color: buttonColor,
          borderRadius:
              BorderRadius.circular(20), // Use a slightly higher border radius
          boxShadow: [
            BoxShadow(
              color: AppColor()
                  .lightColors
                  .shade900
                  .withOpacity(0.1), // Add a subtle box shadow
              blurRadius: 6,
              offset: Offset(5, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
