import 'package:flutter/material.dart';
import 'package:local_taste/lists/product_list/beverage_product_list_vertical.dart';
import 'package:local_taste/lists/product_list/product_list_vertical.dart';
import '../../utils/theme_colors.dart';
import '../product_categories/beverage_items.dart';
import '../product_categories/fruit_Items.dart';
import '../product_categories/snack_items.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Column(
      children: [
        // Breakfast
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 20.0,
            bottom: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'Local Beverages',
                  style: TextStyle(
                    fontSize: 20 * textScaleFactor,
                    color: AppColor().lightColors.shade900,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the ProductPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BeverageProductListVertical(
                        categories: ['Drink', 'Liqueur'],
                      ),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(
                        fontSize: 13 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: AppColor().lightColors.shade700,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColor().lightColors.shade700,
                      size: 20 * textScaleFactor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        BeverageItems(),

        // Lunch
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 15.0,
            bottom: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'Nature\'s Bounty',
                  style: TextStyle(
                    fontSize: 20 * textScaleFactor,
                    color: AppColor().lightColors.shade900,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the ProductPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListVertical(
                        category: 'Fruit',
                      ),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(
                        fontSize: 13 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: AppColor().lightColors.shade700,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColor().lightColors.shade700,
                      size: 20 * textScaleFactor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        FruitItems(),

        // Dinner
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 15.0,
            bottom: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'Authentic Local Snacks',
                  style: TextStyle(
                    fontSize: 20 * textScaleFactor,
                    color: AppColor().lightColors.shade900,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the ProductPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListVertical(
                        category: 'Snack',
                      ),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'View More',
                      style: TextStyle(
                        fontSize: 13 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: AppColor().lightColors.shade700,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColor().lightColors.shade700,
                      size: 20 * textScaleFactor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SnackItems(),
      ],
    );
  }
}
