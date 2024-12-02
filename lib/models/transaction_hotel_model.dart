import 'dart:convert';

import 'package:hotel_booking_app/models/hotel_model.dart';

class TransactionHotelModel {
  final int? id;
  final int userId;
  final HotelModel hotel; // Menyimpan seluruh objek HotelModel
  final int numberOfRooms;
  final double totalPrice;
  final String paymentMethod;
  final DateTime date;

  TransactionHotelModel({
    this.id,
    required this.userId,
    required this.hotel, // Objek hotel
    required this.numberOfRooms,
    required this.totalPrice,
    required this.paymentMethod,
    required this.date,
  });


  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'hotel': jsonEncode(hotel.toMap()),
      'numberOfRooms': numberOfRooms,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'date': date.toIso8601String(),
    };
  }


  factory TransactionHotelModel.fromMap(Map<String, dynamic> map) {
    return TransactionHotelModel(
      userId: map['userId'],
      hotel: HotelModel.fromMap(jsonDecode(map['hotel'])),
      numberOfRooms: map['numberOfRooms'],
      totalPrice: map['totalPrice'],
      paymentMethod: map['paymentMethod'],
      date: DateTime.parse(map['date']),
    );
  }
}
