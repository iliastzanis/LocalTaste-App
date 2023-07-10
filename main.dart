import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_taste/screens/auth_screens/auth_page.dart';
import 'package:local_taste/utils/firebase_options.dart';
import 'package:local_taste/screens/intro_screens/onboarding_screen.dart';
import 'package:local_taste/utils/theme_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  bool introScreensShown = prefs.getBool('introScreensShown') ?? false;
  runApp(MyApp(introScreensShown));
}

class MyApp extends StatelessWidget {
  final bool introScreensShown;
  MyApp(this.introScreensShown);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // transparent status bar
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColor().lightColors,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: introScreensShown ? AuthPage() : OnBoardingScreen(),
      builder: (context, child) {
        return ScrollConfiguration(behavior: AppBehavior(), child: child!);
      },
    );
  }
}

//class to remove scroll glow effect on whole app!
class AppBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
