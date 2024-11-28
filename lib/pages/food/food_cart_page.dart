import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/formatter.dart';
import 'package:hotel_booking_app/database/database_helper.dart';
import 'package:hotel_booking_app/database/pref_helper.dart';
import 'package:hotel_booking_app/models/food_model.dart';
import 'package:hotel_booking_app/models/payment_model.dart';
import 'package:hotel_booking_app/models/transaction_food_model.dart';
import 'package:hotel_booking_app/pages/home/home_page.dart';
import 'package:hotel_booking_app/pages/widgets/buttons.dart';
import 'package:hotel_booking_app/pages/widgets/food_quantity.dart';
import 'package:hotel_booking_app/pages/widgets/payment.dart';

class FoodCartPage extends StatefulWidget {
  final FoodModel food;

  const FoodCartPage({
    super.key,
    required this.food,
  });

  @override
  State<FoodCartPage> createState() => _FoodCartPageState();
}

class _FoodCartPageState extends State<FoodCartPage> {
  String? _selectedPaymentMethod;
  int? userId;
  final ValueNotifier<int?> selectPayment = ValueNotifier<int?>(null);
  int _quantity = 1; // Set the initial quantity to 1

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  // Fungsi untuk mengambil userId dari SharedPreferences
  Future<void> _getUserId() async {
    userId = await PrefHelper.getUserId();
    setState(() {});
  }

  double get totalPrice {
    return widget.food.price * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Cart'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          FoodQuantity(
            food: widget.food,
            qty: _quantity,
            addQty: () {
              setState(() {
                _quantity++;
              });
            },
            minQty: () {
              setState(() {
                if (_quantity > 1) {
                  _quantity--;
                }
              });
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            'Select Payment Method:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 12.0,
            ),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return ValueListenableBuilder<int?>(
                valueListenable: selectPayment,
                builder: (context, activeIndex, child) {
                  return PaymentMethod(
                    isActive: activeIndex == index,
                    data: payment,
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = payment.name;
                        selectPayment.value = index;
                      });
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              const Text(
                'Total Pembayaran',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                formatCurrencyFlexible(totalPrice),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          ValueListenableBuilder<int?>(
            valueListenable: selectPayment,
            builder: (context, selectedIndex, _) {
              return Column(
                children: [
                  if (selectedIndex != null) // Menampilkan jika ada metode yang dipilih
                    Row(
                      children: [
                        const Text(
                          'Pembayaran Melalui',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          payments[selectedIndex].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 40.0,
          ),
          ValueListenableBuilder(
            valueListenable: selectPayment,
            builder: (context, value, _) => Button.filled(
              disabled: value == null,
              onPressed: () async {
                if (_selectedPaymentMethod != null) {
                  TransactionFoodModel transaction = TransactionFoodModel(
                    userId: userId!,
                    food: widget.food, // Kirim objek hotel
                    quantity: _quantity,
                    totalPrice: totalPrice,
                    paymentMethod: _selectedPaymentMethod!,
                    date: DateTime.now(),
                  );

                  // Save transaction to the database
                  _showPaymentDialog(context);
                  await DatabaseHelper().addTransactionFood(transaction);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a payment method')),
                  );
                }
              },
              label: 'Bayar Sekarang',
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pembayaran Berhasil'),
          content: const Text('Pembayaran Anda telah berhasil dilakukan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
