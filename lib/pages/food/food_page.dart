import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/food_model.dart';
import 'package:hotel_booking_app/pages/food/food_detail_page.dart';
import 'package:hotel_booking_app/pages/widgets/food_card.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food List'),
      ),
      body: ListView.separated(
        itemCount: sampleFoods.length,
        padding: const EdgeInsets.all(20),
        separatorBuilder: (context, index) => const SizedBox(
          height: 12.0,
        ),
        itemBuilder: (context, index) {
          final food = sampleFoods[index];
          final isFavorite = ValueNotifier<bool>(false);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailPage(food: food),
                ),
              );
            },
            child: FoodCard(
              food: food,
              isFavorite: isFavorite,
            ),
          );
        },
      ),
    );
  }
}
