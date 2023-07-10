
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_taste/utils/theme_colors.dart';
import '../../screens/app_screens/product_screens/product_page.dart';

class ProductCircles extends StatefulWidget {
  const ProductCircles({super.key});

  @override
  State<ProductCircles> createState() => _ProductCirclesState();
}

class _ProductCirclesState extends State<ProductCircles> {
  void _updateViews(String productId) {
    FirebaseFirestore.instance.collection('products').doc(productId).update({
      'views': FieldValue.increment(1),
    });
  }

  void _openProduct(Map<String, dynamic> productData, String productId) {
    // Update the views in Firebase
    _updateViews(productId);

    // Navigate to the RecipePage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(productData: productData),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream() {
    return FirebaseFirestore.instance
        .collection('products')
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
            stream: _productsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: products.length > 5 ? 5 : products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final productId = products[index].id;
                    final productData = products[index].data();
                    final productImage = productData['imageUrl'] ?? '';
                    final productTitle = productData['title'] ?? '';

                    return GestureDetector(
                      onTap: () => _openProduct(productData,
                          productId), // Pass the recipeData to openRecipe
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
                                  backgroundImage: NetworkImage(productImage),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              productTitle.length > 12
                                  ? '${productTitle.substring(0, 12)}...'
                                  : productTitle,
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
        ));
  }
}
