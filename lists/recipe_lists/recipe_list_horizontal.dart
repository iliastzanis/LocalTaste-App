import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/items_card.dart';
import '../../screens/app_screens/recipe_screens/recipe_page.dart';

class RecipeListHorizontal extends StatefulWidget {
  final String category;
  const RecipeListHorizontal({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<RecipeListHorizontal> createState() => _RecipeListHorizontal();
}

class _RecipeListHorizontal extends State<RecipeListHorizontal> {
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

  Stream<QuerySnapshot<Map<String, dynamic>>> _getRecipesStream() {
    return FirebaseFirestore.instance
        .collection('recipes')
        .where('category', arrayContains: widget.category)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 5.0,
      ),
      child: Container(
        height: 260,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _getRecipesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final recipes = snapshot.data!.docs;
              recipes.shuffle(); // Shuffle the recipes list
              return ListView.builder(
                itemCount: recipes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final recipeId = recipes[index].id;
                  final recipeData = recipes[index].data();
                  final recipeImage = recipeData['imageUrl'] ?? '';
                  final recipeTitle = recipeData['title'] ?? '';

                  return GestureDetector(
                    onTap: () {
                      _openRecipe(recipeData, recipeId);
                    },
                    child: ItemCard(
                      image: recipeImage,
                      title: recipeTitle,
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
