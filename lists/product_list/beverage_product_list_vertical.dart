import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:local_taste/components/bigger_item_card.dart';
import '../../screens/app_screens/product_screens/product_page.dart';
import '../../utils/theme_colors.dart';

class BeverageProductListVertical extends StatefulWidget {
  final List<String> categories;

  const BeverageProductListVertical({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  State<BeverageProductListVertical> createState() =>
      _BeverageProductListVertical();
}

class _BeverageProductListVertical extends State<BeverageProductListVertical> {
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
        .where('category', arrayContainsAny: widget.categories)
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _getProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!.docs;
            products.shuffle(); // Shuffle the recipes list
            return ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final productId = products[index].id;
                final productData = products[index].data();
                final productImage = productData['imageUrl'] ?? '';
                final productTitle = productData['title'] ?? '';

                return GestureDetector(
                  onTap: () {
                    _openProduct(productData, productId);
                  },
                  child: BiggerItemCard(
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
    );
  }
}
