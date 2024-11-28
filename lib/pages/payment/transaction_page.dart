import 'package:flutter/material.dart';
import 'package:hotel_booking_app/database/database_helper.dart';
import 'package:hotel_booking_app/models/transaction_model.dart';
import 'package:hotel_booking_app/pages/widgets/history_card.dart';

class TransactionHistoryPage extends StatelessWidget {
  final int userId;

  const TransactionHistoryPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: FutureBuilder<List<TransactionModel>>(
        future: DatabaseHelper().getTransactionsByUserId(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada histori transaksi'));
          }

          List<TransactionModel> transactions = snapshot.data!;
          return ListView.separated(
            itemCount: transactions.length,
            padding: const EdgeInsets.all(20),
            separatorBuilder: (context, index) => const SizedBox(
              height: 12.0,
            ),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return HistoryCard(
                transaction: transaction,
              );
            },
          );
        },
      ),
    );
  }
}
