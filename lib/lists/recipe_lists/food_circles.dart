
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_taste/utils/theme_colors.dart';
import '../../screens/app_screens/recipe_screens/recipe_page.dart';

class FoodCircles extends StatefulWidget {
  const FoodCircles({super.key});

  @override
  State<FoodCircles> createState() => _FoodCirclesState();
}

class _FoodCirclesState extends State<FoodCircles> {
  void _updateViews(String recipeId) {
    FirebaseFirestore.instance.collection('recipes').doc(recipeId).update({
      'views': FieldValue.increment(1),
    });
  }

  void _openRecipe(Map<String, dynamic> recipeData, String recipeId) {
    // Update the views in Firebase
    _updateViews(recipeId);

    // Navigate to the RecipePage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipePage(recipeData: recipeData),
      ),
    );
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> _recipesStream;

  @override
  void initState() {
    super.initState();
    _recipesStream = FirebaseFirestore.instance
        .collection('recipes')
        .orderBy('views', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 5,
        right: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor().lightColors.shade100.withOpacity(0.5),
          border: Border.all(
            color: AppColor().lightColors.shade900.withOpacity(0.6),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: 120,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _recipesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final recipes = snapshot.data!.docs; // Shuffle the recipes list
              final filteredRecipes = recipes.where((recipe) {
                final recipeData = recipe.data();
                final recipeCategories =
                    List<String>.from(recipeData['category'] ?? []);

                final currentTime = TimeOfDay.now();
                if (currentTime.hour >= 5 && currentTime.hour < 12) {
                  return recipeCategories
                      .any((category) => category == 'Breakfast');
                } else if (currentTime.hour >= 12 && currentTime.hour < 16) {
                  return recipeCategories
                      .any((category) => category == 'Lunch');
                } else {
                  return recipeCategories
                      .any((category) => category == 'Dinner');
                }
              }).toList();

              return ListView.builder(
                itemCount:
                    filteredRecipes.length > 5 ? 5 : filteredRecipes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
                  final recipeData = recipe.data();
                  final recipeId = recipe.id;
                  final recipeImage = recipeData['imageUrl'] ?? '';
                  final recipeTitle = recipeData['title'] ?? '';

                  return GestureDetector(
                    onTap: () => _openRecipe(recipeData,
                        recipeId), // Pass the recipeData to openRecipe
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: AppColor()
                                  .lightColors
                                  .shade500
                                  .withOpacity(0.9),
                              minRadius: 35.0,
                              child: CircleAvatar(
                                radius: 33.0,
                                backgroundImage: NetworkImage(recipeImage),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            recipeTitle.length > 12
                                ? '${recipeTitle.substring(0, 12)}...'
                                : recipeTitle,
                            style: TextStyle(
                              color: AppColor().lightColors.shade900,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
