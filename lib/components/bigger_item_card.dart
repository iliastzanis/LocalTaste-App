import 'package:flutter/material.dart';
import '../utils/theme_colors.dart';

class BiggerItemCard extends StatelessWidget {
  final String image;
  final String title;

  BiggerItemCard({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Customize the background color
          border: Border.all(
            color: AppColor()
                .lightColors
                .shade900
                .withOpacity(0.6), // Customize the border color
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.9),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              child: SizedBox(
                width: 450,
                height: 230,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(12, 10, 12, 10), // Adjust the padding
                decoration: BoxDecoration(
                  color: AppColor()
                      .lightColors
                      .shade50
                      .withOpacity(0.9), // Add a semi-transparent overlay
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColor().lightColors.shade900,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
