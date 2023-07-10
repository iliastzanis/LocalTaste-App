import 'package:flutter/material.dart';
import 'package:local_taste/lists/recipe_lists/recipes_list_vertical.dart';
import 'recipe_list_horizontal.dart';
import '../../utils/theme_colors.dart';

class DinnerListFirst extends StatelessWidget {
  const DinnerListFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Column(
      children: [
        // Dinner
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 20.0,
            bottom: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'More Dinner Flavors',
                  style: TextStyle(
                    fontSize: 20 * textScaleFactor,
                    color: AppColor().lightColors.shade900,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the ProductPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipesListVertical(
                        category: 'Dinner',
                      ),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(
                        fontSize: 13 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: AppColor().lightColors.shade700,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColor().lightColors.shade700,
                      size: 20 * textScaleFactor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        RecipeListHorizontal(category: 'Dinner'),

        // Lunch
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 15.0,
            bottom: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'Lunchtime Favorites',
                  style: TextStyle(
                    fontSize: 20 * textScaleFactor,
                    color: AppColor().lightColors.shade900,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the ProductPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipesListVertical(
                        category: 'Lunch',
                      ),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(
                        fontSize: 13 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: AppColor().lightColors.shade700,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColor().lightColors.shade700,
                      size: 20 * textScaleFactor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        RecipeListHorizontal(category: 'Lunch'),

        // Breakfast
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 15.0,
            bottom: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'Morning Delights',
                  style: TextStyle(
                    fontSize: 20 * textScaleFactor,
                    color: AppColor().lightColors.shade900,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the ProductPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipesListVertical(
                        category: 'Breakfast',
                      ),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(
                        fontSize: 13 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: AppColor().lightColors.shade700,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColor().lightColors.shade700,
                      size: 20 * textScaleFactor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        RecipeListHorizontal(category: 'Breakfast'),
      ],
    );
  }
}
