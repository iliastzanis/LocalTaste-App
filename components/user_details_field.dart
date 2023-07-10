import 'package:flutter/material.dart';
import 'package:local_taste/utils/theme_colors.dart';

class UserDetailsFields extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const UserDetailsFields(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor().lightColors.shade100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      padding: EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //section name
              Text(
                sectionName,
                style: TextStyle(color: AppColor().lightColors.shade500),
              ),
              //edit Button
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.settings),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                color: AppColor().lightColors.shade900,
              )
            ],
          ),

          //text
          Text(
            text,
            style: TextStyle(color: AppColor().lightColors.shade900),
          ),
        ],
      ),
    );
  }
}
