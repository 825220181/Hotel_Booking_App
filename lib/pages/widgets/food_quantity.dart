import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/colors.dart';
import 'package:hotel_booking_app/core/formatter.dart';
import 'package:hotel_booking_app/models/food_model.dart';

class FoodQuantity extends StatelessWidget {
  final FoodModel food;
  final int qty;
  final VoidCallback addQty;
  final VoidCallback minQty;

  const FoodQuantity({
    super.key,
    required this.food,
    required this.qty,
    required this.addQty,
    required this.minQty,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: minQty,
                  child: const ColoredBox(
                    color: AppColors.primary,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.remove,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 4.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$qty'),
              ),
              const SizedBox(
                width: 4.0,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: addQty,
                  child: const ColoredBox(
                    color: AppColors.primary,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.add,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
