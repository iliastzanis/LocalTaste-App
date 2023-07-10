import 'package:flutter/material.dart';
import '../../utils/theme_colors.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().lightColors.shade500,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              // Rounded image in the center of the screen
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/welcome2.png'),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Title with centered bold text
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  'Find new products',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor().lightColors.shade100,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Brief description text also centered
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
                child: Text(
                  'Find the best local products and ingredients for your next meal',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColor().lightColors.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
