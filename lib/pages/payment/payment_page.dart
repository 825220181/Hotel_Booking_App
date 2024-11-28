import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/formatter.dart';
import 'package:hotel_booking_app/database/pref_helper.dart';
import 'package:hotel_booking_app/models/hotel_model.dart';
import 'package:hotel_booking_app/models/payment_model.dart';
import 'package:hotel_booking_app/pages/home/home_page.dart';
import 'package:hotel_booking_app/pages/widgets/buttons.dart';
import 'package:hotel_booking_app/pages/widgets/hotel_card.dart';
import 'package:hotel_booking_app/pages/widgets/payment.dart';
import 'package:hotel_booking_app/database/database_helper.dart';
import 'package:hotel_booking_app/models/transaction_model.dart';

class PaymentPage extends StatefulWidget {
  final HotelModel hotel; // Gunakan objek hotel, bukan hanya nama hotel
  final int numberOfRooms;
  final double totalPrice;

  const PaymentPage({
    super.key,
    required this.hotel, // Kirim objek hotel
    required this.numberOfRooms,
    required this.totalPrice,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedPaymentMethod;
  int? userId;
  final ValueNotifier<int?> selectPayment = ValueNotifier<int?>(null);

  @override
  void initState() {
    super.initState();
    // Ambil userId saat halaman diinisialisasi
    _getUserId();
  }

  // Fungsi untuk mengambil userId dari SharedPreferences
  Future<void> _getUserId() async {
    userId = await PrefHelper.getUserId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          HotelCard(
            hotel: widget.hotel,
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
                        _selectedPaymentMethod = payment.name; // Simpan nama metode pembayaran
                        selectPayment.value = index; // Memperbarui status pembayaran yang dipilih
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
                formatCurrencyFlexible(widget.totalPrice),
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

          // Confirm button

          ValueListenableBuilder(
            valueListenable: selectPayment,
            builder: (context, value, _) => Button.filled(
              disabled: value == null,
              onPressed: () async {
                if (_selectedPaymentMethod != null) {
                  TransactionModel transaction = TransactionModel(
                    userId: userId!,
                    hotel: widget.hotel, // Kirim objek hotel
                    numberOfRooms: widget.numberOfRooms,
                    totalPrice: widget.totalPrice,
                    paymentMethod: _selectedPaymentMethod!,
                    date: DateTime.now(),
                  );

                  // Save transaction to the database
                  _showPaymentDialog(context);
                  await DatabaseHelper().insertTransaction(transaction);
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
