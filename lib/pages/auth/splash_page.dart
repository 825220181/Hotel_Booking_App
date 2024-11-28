import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/colors.dart';
import 'package:hotel_booking_app/database/pref_helper.dart';
import 'package:hotel_booking_app/pages/home/home_page.dart';
import 'package:hotel_booking_app/pages/auth/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  _checkLoginState() async {
    await Future.delayed(const Duration(seconds: 2));
    String? username = await PrefHelper.getUsername();
    log('Username: $username');

    if (mounted) {
      if (username != null && username.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading..',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 16.0),
            CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
