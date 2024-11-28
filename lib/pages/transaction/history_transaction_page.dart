import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/colors.dart';
import 'package:hotel_booking_app/database/database_helper.dart';
import 'package:hotel_booking_app/models/transaction_food_model.dart';
import 'package:hotel_booking_app/models/transaction_hotel_model.dart';
import 'package:hotel_booking_app/pages/widgets/history_hotel_card.dart';
import 'package:hotel_booking_app/pages/widgets/history_food_card.dart';

class HistoryTransactionPage extends StatelessWidget {
  final int userId;
  const HistoryTransactionPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text(
            'History Transaction',
          ),
          bottom: TabBar(
            indicatorColor: AppColors.primary,
            indicatorWeight: 3.5,
            labelColor: AppColors.primary,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: AppColors.black.withOpacity(0.2),
            tabs: const [
              Tab(text: 'Hotels'),
              Tab(text: 'Foods'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HistoryHotels(userId: userId),
            HistoryFoods(userId: userId),
          ],
        ),
      ),
    );
  }
}

class HistoryHotels extends StatelessWidget {
  final int userId;
  const HistoryHotels({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionHotelModel>>(
      future: DatabaseHelper().getTransactionsHotelByUserId(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada riwayat transaksi hotel'));
        }

        List<TransactionHotelModel> transactions = snapshot.data!;
        return ListView.separated(
          itemCount: transactions.length,
          padding: const EdgeInsets.all(20),
          separatorBuilder: (context, index) => const SizedBox(
            height: 12.0,
          ),
          itemBuilder: (context, index) {
            final hotel = transactions[index];
            return HistoryHotelCard(
              hotelTransaction: hotel,
            );
          },
        );
      },
    );
  }
}

class HistoryFoods extends StatelessWidget {
  final int userId;
  const HistoryFoods({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionFoodModel>>(
      future: DatabaseHelper().getTransactionsFoodByUserId(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada riwayat transaksi makanan'));
        }

        List<TransactionFoodModel> transactions = snapshot.data!;
        return ListView.separated(
          itemCount: transactions.length,
          padding: const EdgeInsets.all(20),
          separatorBuilder: (context, index) => const SizedBox(
            height: 12.0,
          ),
          itemBuilder: (context, index) {
            final food = transactions[index];
            return HistoryFoodCard(
              foodTransaction: food,
            );
          },
        );
      },
    );
  }
}
