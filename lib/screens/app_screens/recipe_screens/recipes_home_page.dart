import 'package:flutter/material.dart';

import '../../../lists/recipe_lists/food_circles.dart';
import '../../../lists/recipe_lists/meal_list_selector.dart';
import '../../../utils/theme_colors.dart';

class RecipesHomePage extends StatelessWidget {
  const RecipesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current time
    DateTime now = DateTime.now();

    // Determine the time of day based on the current hour
    String timeOfDay = '';
    if (now.hour >= 5 && now.hour < 12) {
      timeOfDay = 'Morning';
    } else if (now.hour >= 12 && now.hour < 16) {
      timeOfDay = 'Lunch';
    } else {
      timeOfDay = 'Evening';
    }

    return SingleChildScrollView(
      // Set the width to occupy the entire screen
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // I want to eat
          Padding(
            padding: const EdgeInsets.only(
              top: 25.0,
              bottom: 5,
              left: 16,
              right: 16,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hot picks:',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: AppColor().lightColors.shade900,
                    ),
                  ),
                  TextSpan(
                    text: ' $timeOfDay',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: AppColor().lightColors.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // LocalTaste Selections
          FoodCircles(),

          // FoodCards depending on the time of day
          MealListSelector(
            timeOfDay: timeOfDay,
          ),
        ],
      ),
    );
  }
}
