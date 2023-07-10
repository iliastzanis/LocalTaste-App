import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/theme_colors.dart';

class ProductPage extends StatefulWidget {
  final Map<String, dynamic> productData;

  const ProductPage({required this.productData});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late SharedPreferences _preferences;
  List<Map<String, dynamic>> favoritedProducts = [];

  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  // Initialize SharedPreferences instance
  void initializePreferences() async {
    _preferences = await SharedPreferences.getInstance();
    loadFavoritedProducts();
  }

  // Load favorited recipes from SharedPreferences
  void loadFavoritedProducts() {
    setState(() {
      final products = _preferences.getStringList('favoritedProducts');
      favoritedProducts = products != null
          ? products
              .map((product) => jsonDecode(product) as Map<String, dynamic>)
              .toList()
          : [];
    });
  }

  // Save favorited recipes to SharedPreferences
  void saveFavoritedProducts() {
    final encodedProducts =
        favoritedProducts.map((product) => jsonEncode(product)).toList();
    _preferences.setStringList('favoritedProducts', encodedProducts);
  }

  // Toggle recipe favorite status
  void toggleFavoriteStatus() {
    final productTitle = widget.productData['title'] ?? '';

    final existingProductIndex = favoritedProducts
        .indexWhere((product) => product['title'] == productTitle);
    if (existingProductIndex != -1) {
      favoritedProducts.removeAt(existingProductIndex);
    } else {
      favoritedProducts.add(widget.productData);
    }
    saveFavoritedProducts();
  }

  // Check if recipe is favorited
  bool isProductFavorited() {
    final productTitle = widget.productData['title'] ?? '';
    return favoritedProducts.any((product) => product['title'] == productTitle);
  }

  @override
  Widget build(BuildContext context) {
    final productImage = widget.productData['imageUrl'] ?? '';
    final productTitle = widget.productData['title'] ?? '';
    final productDescription = widget.productData['description'] ?? '';

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
                      image: NetworkImage(productImage),
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
                        productTitle,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor().lightColors.shade900,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isProductFavorited()
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
                  productDescription,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor().lightColors.shade800,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Other Sections (e.g., Reviews, Add to Cart, etc.)
              // Add your desired sections here
            ],
          ),
        ),
      ),
    );
  }
}
