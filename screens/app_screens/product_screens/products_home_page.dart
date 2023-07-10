import 'package:flutter/material.dart';
import 'package:local_taste/lists/product_list/product_list.dart';
import '../../../lists/product_list/product_circles.dart';
import '../../../utils/theme_colors.dart';

class ProductsHomePage extends StatelessWidget {
  const ProductsHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Set the width to occupy the entire screen
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // I want to eat
          Padding(
            padding: const EdgeInsets.only(
              top: 25.0,
              bottom: 5,
              left: 16,
              right: 16,
            ),
            child: RichText(
              text: TextSpan(
                text: 'Today\'s',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: AppColor().lightColors.shade900,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Products',
                    style: TextStyle(
                      color: AppColor().lightColors.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // LocalTaste Selections
          ProductCircles(),

          // FoodCards depending on the time of day
          ProductList(),
        ],
      ),
    );
  }
}
