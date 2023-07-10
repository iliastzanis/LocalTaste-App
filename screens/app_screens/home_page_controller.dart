import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'controller_screens/favorites_page.dart';
import 'controller_screens/home_page.dart';
import 'package:local_taste/screens/app_screens/controller_screens/profile_page.dart';
import 'package:local_taste/screens/app_screens/controller_screens/search_page.dart';
import '../../utils/theme_colors.dart';

class HomePageController extends StatefulWidget {
  const HomePageController({super.key});

  @override
  State<HomePageController> createState() => _HomePageControllerState();
}

class _HomePageControllerState extends State<HomePageController> {
  int _index = 0;

  final screens = [
    HomePage(),
    FavoritesPage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      //bottom nav bar
      bottomNavigationBar: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: GNav(
              backgroundColor: Colors.grey.shade50,
              color: AppColor().lightColors.shade900,
              activeColor: AppColor().lightColors.shade100,
              tabBackgroundColor: AppColor().lightColors.shade500,
              tabActiveBorder: Border.all(
                  color: AppColor().lightColors.shade900.withOpacity(0.7),
                  width: 1),
              gap: 8,
              haptic: false,
              duration: Duration(milliseconds: 400),
              onTabChange: (index) => setState(() => _index = index),
              padding: EdgeInsets.all(11),
              tabs: const [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.favorite_border, text: 'Favorites'),
                GButton(icon: Icons.search, text: 'Search'),
                GButton(icon: Icons.person, text: 'Profile'),
              ]),
        ),
      ),
    );
  }
}
