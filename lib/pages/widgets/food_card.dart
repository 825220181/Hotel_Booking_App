import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/colors.dart';
import 'package:hotel_booking_app/core/formatter.dart';
import 'package:hotel_booking_app/models/food_model.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;
  final ValueNotifier<bool> isFavorite;

  const FoodCard({
    super.key,
    required this.food,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.grey.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Image.asset(
              food.imageUrl,
              width: 68.0,
              height: 68.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 14.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  formatCurrencyFlexible(food.price),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Icon favorit yang bisa diubah warnanya
          ValueListenableBuilder<bool>(
            valueListenable: isFavorite,
            builder: (context, isFav, child) {
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : AppColors.grey,
                ),
                onPressed: () {
                  // Toggle status favorit
                  isFavorite.value = !isFav;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
