import 'package:flutter/material.dart';
import 'package:hotel_booking_app/models/hotel_model.dart';
import 'package:hotel_booking_app/pages/hotel/hotel_detail_page.dart' as detail_page;
import 'package:hotel_booking_app/pages/widgets/hotel_card.dart';


class HotelPage extends StatelessWidget {
  const HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Room List'),
      ),
      body: ListView.separated(
        itemCount: sampleHotels.length,
        padding: const EdgeInsets.all(20),
        separatorBuilder: (context, index) => const SizedBox(
          height: 12.0,
        ),
        itemBuilder: (context, index) {
          final hotel = sampleHotels[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => detail_page.HotelDetailPage(hotel: hotel),
                ),
              );
            },
            child: HotelCard(hotel: hotel),
          );
        },
      ),
    );
  }
}
