import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_taste/components/bigger_item_card.dart';
import 'package:local_taste/components/my_text_fields.dart';
import 'package:local_taste/components/search_text_field.dart';
import 'package:local_taste/screens/app_screens/recipe_screens/recipe_page.dart';

class SearchRecipesPage extends StatefulWidget {
  const SearchRecipesPage({Key? key}) : super(key: key);

  @override
  State<SearchRecipesPage> createState() => _SearchRecipesPageState();
}

class _SearchRecipesPageState extends State<SearchRecipesPage> {
  TextEditingController _searchController = TextEditingController();
  Stream<QuerySnapshot>? _searchResults;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchRecipes);
  }

  @override
  void dispose() {
    _searchController.removeListener(_searchRecipes);
    _searchController.dispose();
    super.dispose();
  }

  void _searchRecipes() {
    String searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      setState(() {
        _searchResults = null;
      });
    } else {
      List<String> searchWords = searchText.split(' ');
      List<String> searchTerms = searchWords.map((word) {
        String firstLetter = word.substring(0, 1).toUpperCase();
        String remainingLetters = word.substring(1).toLowerCase();
        return '$firstLetter$remainingLetters';
      }).toList();

      setState(() {
        _searchResults = FirebaseFirestore.instance
            .collection('recipes')
            .where('title', isGreaterThanOrEqualTo: searchTerms[0])
            .where('title',
                isLessThanOrEqualTo: searchTerms[searchTerms.length - 1] + 'z')
            .snapshots();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchTextField(
          controller_: _searchController,
          hintText: 'Search by Recipe Title',
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _searchResults,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                if (_searchController.text.isEmpty) {
                  return Center(
                    child: Text('Search for recipes'),
                  );
                } else {
                  return Center(
                    child: Text('No recipes found.'),
                  );
                }
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var recipeData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipePage(recipeData: recipeData),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 15,
                      ),
                      child: BiggerItemCard(
                        image: recipeData['imageUrl'],
                        title: recipeData['title'],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
