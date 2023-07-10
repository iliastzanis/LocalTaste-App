import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_taste/screens/app_screens/recipe_screens/recipes_home_page.dart';
import 'package:local_taste/screens/app_screens/product_screens/products_home_page.dart';
import 'package:local_taste/utils/theme_colors.dart';
import '../../../components/filter_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: true,
        title: RichText(
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    FilterButton(
                      text: 'Recipes',
                      onPressed: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                      isActive: currentIndex == 0,
                    ),
                    SizedBox(width: 15),
                    FilterButton(
                      text: 'Products',
                      onPressed: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      isActive: currentIndex == 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: [
                RecipesHomePage(),
                ProductsHomePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
