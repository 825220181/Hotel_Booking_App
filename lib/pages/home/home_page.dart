import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/colors.dart';
import 'package:hotel_booking_app/database/pref_helper.dart';
import 'package:hotel_booking_app/pages/auth/login_page.dart';
import 'package:hotel_booking_app/pages/food/food_page.dart';
import 'package:hotel_booking_app/pages/hotel/hotel_page.dart';
import 'package:hotel_booking_app/pages/transaction/history_transaction_page.dart';
import 'package:hotel_booking_app/pages/widgets/buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () async {
              // Menampilkan dialog konfirmasi logout
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Apakah anda yakin untuk logout?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Menutup dialog tanpa logout
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await PrefHelper.clearLoginState(); // Membersihkan status login
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          }
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HotelPage(),
                  ),
                );
              },
              label: 'Hotel Reservation',
            ),
            const SizedBox(
              height: 20.0,
            ),
            Button.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FoodPage(),
                  ),
                );
              },
              label: 'Food Service',
            ),
            const SizedBox(
              height: 20.0,
            ),
            Button.filled(
              onPressed: () async {
                // Ambil userId dari SharedPreferences
                int? userId = await PrefHelper.getUserId();
                // Pastikan userId ada, jika tidak, lakukan tindakan tertentu
                if (context.mounted) {
                  if (userId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryTransactionPage(userId: userId), // Kirim userId ke TransactionHistoryPage
                      ),
                    );
                  } else {
                    // Tindakan jika userId tidak ditemukan (misalnya, tidak login)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please log in first')),
                    );
                  }
                }
              },
              label: 'History Transaction',
            ),
          ],
        ),
      ),
    );
  }
}
