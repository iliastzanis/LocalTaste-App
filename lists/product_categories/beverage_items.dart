import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/items_card.dart';
import '../../screens/app_screens/product_screens/product_page.dart';

class BeverageItems extends StatefulWidget {
  const BeverageItems({Key? key}) : super(key: key);

  @override
  State<BeverageItems> createState() => _BeverageItemsState();
}

class _BeverageItemsState extends State<BeverageItems> {
  void _updateViews(String productId) {
    FirebaseFirestore.instance.collection('products').doc(productId).update({
      'views': FieldValue.increment(1),
    });
  }

  void _openProduct(Map<String, dynamic> productData, String productId) {
    // Update the views in Firebase
    _updateViews(productId);

    // Navigate to the ProductPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(productData: productData),
      ),
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _getProductsStream() {
    return FirebaseFirestore.instance
        .collection('products')
        .where('category', arrayContainsAny: ['Drink', 'Liqueur']).snapshots();
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
          stream: _getProductsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final products = snapshot.data!.docs;
              products.shuffle(); // Shuffle the recipes list
              return ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final productId = products[index].id;
                  final productData = products[index].data();
                  final productImage = productData['imageUrl'] ?? '';
                  final productTitle = productData['title'] ?? '';

                  return GestureDetector(
                    onTap: () {
                      _openProduct(productData, productId);
                    },
                    child: ItemCard(
                      image: productImage,
                      title: productTitle,
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
