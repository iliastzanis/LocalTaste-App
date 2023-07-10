import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_taste/components/bigger_item_card.dart';
import 'package:local_taste/screens/app_screens/product_screens/product_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProductsPage extends StatefulWidget {
  const FavoriteProductsPage({Key? key}) : super(key: key);

  @override
  _FavoriteProductsPageState createState() => _FavoriteProductsPageState();
}

class _FavoriteProductsPageState extends State<FavoriteProductsPage> {
  List<Map<String, dynamic>> favoritedProducts = [];

  @override
  void initState() {
    super.initState();
    loadFavoritedProducts();
  }

  // Load favorited recipes from SharedPreferences
  void loadFavoritedProducts() async {
    final preferences = await SharedPreferences.getInstance();
    final products = preferences.getStringList('favoritedProducts');
    setState(() {
      favoritedProducts = products != null
          ? products
              .map((product) => jsonDecode(product) as Map<String, dynamic>)
              .toList()
          : [];
    });
  }

  // Refresh the list of favorited products
  void refreshFavoriteProducts() {
    loadFavoritedProducts();
  }

  @override
  Widget build(BuildContext context) {
    if (favoritedProducts.isEmpty) {
      return Center(
        child: Text('No favorite products yet'),
      );
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: favoritedProducts.length,
        itemBuilder: (context, index) {
          final product = favoritedProducts[index];
          final image = product['imageUrl'];
          final title = product['title'];
          return GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(productData: product),
                ),
              );
              refreshFavoriteProducts();
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
