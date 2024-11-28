import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_booking_app/core/colors.dart';
import 'package:hotel_booking_app/core/formatter.dart';
import 'package:hotel_booking_app/models/food_model.dart';
import 'package:hotel_booking_app/pages/food/food_cart_page.dart';
import 'package:hotel_booking_app/pages/widgets/buttons.dart';

class FoodDetailPage extends StatelessWidget {
  final FoodModel food;

  const FoodDetailPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Food Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Stack(
                children: [
                  // Image Background
                  Image.asset(
                    food.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Best Seller',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              food.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            const SizedBox(height: 8),
            Text(
              formatCurrencyFlexible(food.price),
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            RatingBarIndicator(
              rating: food.rating,
              itemCount: 5, // Number of stars
              itemSize: 22.0, // Adjust the size of the stars
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              direction: Axis.horizontal, // Optional, but can be useful if you want to control the layout
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              food.description,
              style: TextStyle(
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Button.filled(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodCartPage(food: food),
                ),
              );
            },
            label: 'Add to Cart',
          ),
        ),
      ),
    );
  }
}
