import 'package:flutter/material.dart';
import 'package:local_taste/components/bigger_item_card.dart';
import 'package:local_taste/screens/app_screens/recipe_screens/recipe_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteRecipesPage extends StatefulWidget {
  const FavoriteRecipesPage({Key? key}) : super(key: key);

  @override
  _FavoriteRecipesPageState createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
  List<Map<String, dynamic>> favoritedRecipes = [];

  @override
  void initState() {
    super.initState();
    loadFavoritedRecipes();
  }

  // Load favorited recipes from SharedPreferences
  void loadFavoritedRecipes() async {
    final preferences = await SharedPreferences.getInstance();
    final recipes = preferences.getStringList('favoritedRecipes');
    setState(() {
      favoritedRecipes = recipes != null
          ? recipes
              .map((recipe) => jsonDecode(recipe) as Map<String, dynamic>)
              .toList()
          : [];
    });
  }

  // Refresh the list of favorited recipes
  void refreshFavoriteRecipes() {
    loadFavoritedRecipes();
  }

  @override
  Widget build(BuildContext context) {
    if (favoritedRecipes.isEmpty) {
      return Center(
        child: Text('No favorite recipes yet'),
      );
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: favoritedRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoritedRecipes[index];
          final image = recipe['imageUrl'];
          final title = recipe['title'];
          return GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipePage(recipeData: recipe),
                ),
              );
              refreshFavoriteRecipes();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 15,
              ),
              child: BiggerItemCard(
                image: image,
                title: title,
              ),
            ),
          );
        },
      ),
    );
  }
}
