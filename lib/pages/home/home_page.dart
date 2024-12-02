import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/colors.dart';
import 'package:hotel_booking_app/database/pref_helper.dart';
import 'package:hotel_booking_app/pages/auth/login_page.dart';
import 'package:hotel_booking_app/pages/food/food_page.dart';
import 'package:hotel_booking_app/pages/hotel/hotel_page.dart';
import 'package:hotel_booking_app/pages/transaction/history_transaction_page.dart';

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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Apakah anda yakin untuk logout?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await PrefHelper.clearLoginState();
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
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
          children: [
            _buildMenuItem(
              context,
              icon: Icons.history,
              label: "History\nTransaction",
              onTap: () async {
                int? userId = await PrefHelper.getUserId();
                if (context.mounted) {
                  if (userId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HistoryTransactionPage(userId: userId),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please log in first')),
                    );
                  }
                }
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.fastfood,
              label: "Food Service",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FoodPage(),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.hotel,
              label: "Hotel",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HotelPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 36, // Ukuran ikon
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8.0),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10.0), // Ukuran font
            ),
          ),
        ],
      ),
    );
  }
}
