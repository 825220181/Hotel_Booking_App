import 'dart:convert';

import 'package:hotel_booking_app/models/hotel_model.dart';

class TransactionModel {
  final int? id;
  final int userId;
  final HotelModel hotel; // Menyimpan seluruh objek HotelModel
  final int numberOfRooms;
  final double totalPrice;
  final String paymentMethod;
  final DateTime date;

  TransactionModel({
    this.id,
    required this.userId,
    required this.hotel, // Objek hotel
    required this.numberOfRooms,
    required this.totalPrice,
    required this.paymentMethod,
    required this.date,
  });

  // Mengonversi objek TransactionModel ke Map untuk disimpan di SQLite
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'hotel': jsonEncode(hotel.toMap()), // Menyimpan seluruh data hotel dalam JSON
      'numberOfRooms': numberOfRooms,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'date': date.toIso8601String(),
    };
  }

  // Membaca dari Map dan membuat objek TransactionModel
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      userId: map['userId'],
      hotel: HotelModel.fromMap(jsonDecode(map['hotel'])), // Mengambil objek hotel dari JSON
      numberOfRooms: map['numberOfRooms'],
      totalPrice: map['totalPrice'],
      paymentMethod: map['paymentMethod'],
      date: DateTime.parse(map['date']),
    );
  }
}
