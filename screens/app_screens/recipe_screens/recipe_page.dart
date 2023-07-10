import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_taste/utils/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipePage extends StatefulWidget {
  final Map<String, dynamic> recipeData;

  const RecipePage({required this.recipeData});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<bool> ingredientCheckedList = [];
  late SharedPreferences _preferences;
  List<Map<String, dynamic>> favoritedRecipes = [];

  @override
  void initState() {
    super.initState();
    // Initialize the ingredientCheckedList with false for each ingredient
    ingredientCheckedList = List.generate(
      widget.recipeData['ingredients'].length,
      (index) => false,
    );
    initializePreferences();
  }

  // Initialize SharedPreferences instance
  void initializePreferences() async {
    _preferences = await SharedPreferences.getInstance();
    loadFavoritedRecipes();
  }

  // Load favorited recipes from SharedPreferences
  void loadFavoritedRecipes() {
    setState(() {
      final recipes = _preferences.getStringList('favoritedRecipes');
      favoritedRecipes = recipes != null
          ? recipes
              .map((recipe) => jsonDecode(recipe) as Map<String, dynamic>)
              .toList()
          : [];
    });
  }

  // Save favorited recipes to SharedPreferences
  void saveFavoritedRecipes() {
    final encodedRecipes =
        favoritedRecipes.map((recipe) => jsonEncode(recipe)).toList();
    _preferences.setStringList('favoritedRecipes', encodedRecipes);
  }

  // Toggle recipe favorite status
  void toggleFavoriteStatus() {
    final recipeTitle = widget.recipeData['title'] ?? '';

    final existingRecipeIndex =
        favoritedRecipes.indexWhere((recipe) => recipe['title'] == recipeTitle);
    if (existingRecipeIndex != -1) {
      favoritedRecipes.removeAt(existingRecipeIndex);
    } else {
      favoritedRecipes.add(widget.recipeData);
    }
    saveFavoritedRecipes();
  }

  // Check if recipe is favorited
  bool isRecipeFavorited() {
    final recipeTitle = widget.recipeData['title'] ?? '';
    return favoritedRecipes.any((recipe) => recipe['title'] == recipeTitle);
  }

  @override
  Widget build(BuildContext context) {
    final recipeImage = widget.recipeData['imageUrl'] ?? '';
    final recipeTitle = widget.recipeData['title'] ?? '';
    final recipeDescription = widget.recipeData['description'] ?? '';
    final recipeIngredients = widget.recipeData['ingredients'] ?? [];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor().lightColors.shade900),
          onPressed: () => Navigator.pop(context),
        ),
        title: Stack(
          alignment: Alignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Local',
                    style: TextStyle(
                      color: AppColor().lightColors.shade500,
                      fontSize: 25,
                    ),
                  ),
                  TextSpan(
                    text: 'Taste',
                    style: TextStyle(
                      color: AppColor().lightColors.shade900,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Recipe Image
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(recipeImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Recipe Title with Favorite Icon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        recipeTitle,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor().lightColors.shade900,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isRecipeFavorited()
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      onPressed: () {
                        setState(() {
                          toggleFavoriteStatus();
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Recipe Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  recipeDescription,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor().lightColors.shade800,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Recipe Ingredients
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColor().lightColors.shade900,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipeIngredients.length,
                      itemBuilder: (context, index) {
                        final ingredient = recipeIngredients[index];
                        final isChecked = ingredientCheckedList[index];

                        return Theme(
                          data: ThemeData(
                            unselectedWidgetColor: AppColor()
                                .lightColors
                                .shade900, // Set the color for unchecked checkbox
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  ingredientCheckedList[index] = value!;
                                });
                              },
                              checkColor: AppColor()
                                  .lightColors
                                  .shade50, // Set the inactive color
                              activeColor: AppColor()
                                  .lightColors
                                  .shade500, // Set the active color
                            ),
                            title: Text(
                              ingredient,
                              style: TextStyle(
                                color: AppColor().lightColors.shade800,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Other Sections (e.g., Reviews, Add to Cart, etc.)
              // Add your desired sections here
            ],
          ),
        ),
      ),
    );
  }
}
