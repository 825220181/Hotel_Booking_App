import 'dart:convert';

import 'package:hotel_booking_app/models/food_model.dart';

class TransactionFoodModel {
  final int? id;
  final int userId;
  final FoodModel food;
  final int quantity;
  final double totalPrice;
  final String paymentMethod;
  final DateTime date;

  TransactionFoodModel({
    this.id,
    required this.userId,
    required this.food,
    required this.quantity,
    required this.totalPrice,
    required this.paymentMethod,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'food': jsonEncode(food.toMap()),
      'quantity': quantity,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'date': date.toIso8601String(),
    };
  }

  factory TransactionFoodModel.fromMap(Map<String, dynamic> map) {
    return TransactionFoodModel(
      userId: map['userId'],
      food: FoodModel.fromMap(jsonDecode(map['food'])),
      quantity: map['quantity'],
      totalPrice: map['totalPrice'],
      paymentMethod: map['paymentMethod'],
      date: DateTime.parse(map['date']),
    );
  }
}
