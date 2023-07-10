import 'package:flutter/material.dart';
import 'package:local_taste/screens/auth_screens/auth_page.dart';
import 'package:local_taste/screens/intro_screens/intro_page_1.dart';
import 'package:local_taste/screens/intro_screens/intro_page_2.dart';
import 'package:local_taste/screens/intro_screens/intro_page_3.dart';
import 'package:local_taste/screens/intro_screens/intro_page_4.dart';
import 'package:local_taste/screens/intro_screens/intro_page_5.dart';
import 'package:local_taste/utils/theme_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //controller to keep track of pages
  PageController _controller = PageController();

  Future<void> _setIntroScreensShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('introScreensShown', true);
  }

  //keep track if we are on last page
  bool onLastPage = false;
  //boolean variable to keep track if the Next button is enabled or not
  bool _nextButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            onLastPage = (index == 4);
          });
        },
        children: [
          IntroPage1(),
          IntroPage2(),
          IntroPage3(),
          IntroPage4(),
          IntroPage5(),
        ],
      ),
      //dot indicator
      Container(
        alignment: Alignment(0, 0.88),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Skip button
            GestureDetector(
              onTap: () {
                _setIntroScreensShown();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthPage();
                    },
                  ),
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: AppColor().lightColors.shade100,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            //Page Indicator
            SmoothPageIndicator(
              controller: _controller,
              count: 5,
              effect: WormEffect(
                activeDotColor: AppColor().lightColors.shade700,
                dotColor: AppColor().lightColors.shade100,
                dotHeight: 15,
                dotWidth: 15,
              ),
            ),

            //Next button
            onLastPage
                ? GestureDetector(
                    onTap: () {
                      _setIntroScreensShown();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AuthPage();
                          },
                        ),
                      );
                    },
                    child: Icon(
                      Icons.check,
                      color: AppColor().lightColors.shade100,
                      size: 30.0,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      if (_nextButtonEnabled) {
                        _nextButtonEnabled = false;
                        _controller.nextPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeIn,
                        );
                        Future.delayed(Duration(milliseconds: 400), () {
                          setState(() {
                            _nextButtonEnabled = true;
                          });
                        });
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColor().lightColors.shade100,
                      size: 30.0,
                    ),
                  ),
          ],
        ),
      ),
    ]));
  }
}
