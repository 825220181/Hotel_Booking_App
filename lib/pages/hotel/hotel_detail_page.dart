import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/colors.dart';
import 'package:hotel_booking_app/core/formatter.dart';
import 'package:hotel_booking_app/models/hotel_model.dart';
import 'package:hotel_booking_app/pages/hotel/hotel_payment_page.dart';
import 'package:hotel_booking_app/pages/widgets/buttons.dart';

class HotelDetailPage extends StatefulWidget {
  final HotelModel hotel;

  const HotelDetailPage({super.key, required this.hotel});

  @override
  State<HotelDetailPage> createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  int _numberOfRooms = 1; // Default to 1 room

  // Method to update the number of rooms
  void _increaseRooms() {
    setState(() {
      _numberOfRooms++;
    });
  }

  void _decreaseRooms() {
    setState(() {
      if (_numberOfRooms > 1) {
        _numberOfRooms--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;
    final totalPrice = hotel.price * _numberOfRooms; // Calculate total price

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Hotel Room Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.asset(
                widget.hotel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.hotel.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${formatCurrencyFlexible(widget.hotel.price)}/',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(
                    text: 'night',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.hotel.description,
              style: TextStyle(
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: InkWell(
                    onTap: _decreaseRooms,
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
                  child: Text('$_numberOfRooms night'),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: InkWell(
                    onTap: _increaseRooms,
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
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Button.filled(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HotelPaymentPage(
                    hotel: widget.hotel,
                    numberOfRooms: _numberOfRooms,
                    totalPrice: widget.hotel.price * _numberOfRooms,
                  ),
                ),
              );
            },
            label: 'Book Now (${formatCurrencyFlexible(totalPrice)})',
          ),
        ),
      ),
    );
  }
}
