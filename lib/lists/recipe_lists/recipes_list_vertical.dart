import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_taste/components/bigger_item_card.dart';
import '../../screens/app_screens/recipe_screens/recipe_page.dart';
import '../../utils/theme_colors.dart';

class RecipesListVertical extends StatefulWidget {
  final String category;

  const RecipesListVertical({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<RecipesListVertical> createState() => _RecipesListVerticalState();
}

class _RecipesListVerticalState extends State<RecipesListVertical> {
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
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _getRecipesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final recipes = snapshot.data!.docs;
              recipes.shuffle(); // Shuffle the recipes list
              return ListView.builder(
                itemCount: recipes.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final recipeId = recipes[index].id;
                  final recipeData = recipes[index].data();
                  final recipeImage = recipeData['imageUrl'] ?? '';
                  final recipeTitle = recipeData['title'] ?? '';

                  return GestureDetector(
                    onTap: () {
                      _openRecipe(recipeData, recipeId);
                    },
                    child: BiggerItemCard(
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
