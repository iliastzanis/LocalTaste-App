import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_taste/components/bigger_item_card.dart';
import 'package:local_taste/screens/app_screens/product_screens/product_page.dart';
import '../../../components/my_text_fields.dart';
import '../../../components/search_text_field.dart';

class SearchProductsPage extends StatefulWidget {
  const SearchProductsPage({super.key});

  @override
  State<SearchProductsPage> createState() => _SearchProductsPageState();
}

class _SearchProductsPageState extends State<SearchProductsPage> {
  TextEditingController _searchController = TextEditingController();
  Stream<QuerySnapshot>? _searchResults;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchProducts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_searchProducts);
    _searchController.dispose();
    super.dispose();
  }

  void _searchProducts() {
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
            .collection('products')
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
          hintText: 'Search by Product Title',
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
                    child: Text('Search for products'),
                  );
                } else {
                  return Center(
                    child: Text('No products found.'),
                  );
                }
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var productData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductPage(productData: productData),
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
                        image: productData['imageUrl'],
                        title: productData['title'],
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
