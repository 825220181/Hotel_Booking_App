import 'dart:convert';

import 'package:hotel_booking_app/models/register_model.dart';
import 'package:hotel_booking_app/models/transaction_food_model.dart';
import 'package:hotel_booking_app/models/transaction_hotel_model.dart';
import 'package:hotel_booking_app/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  // Mendapatkan instance database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // Inisialisasi database
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'hotels.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    // Tabel users
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      email TEXT,
      password TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE hotel_transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER,
      hotel TEXT, 
      numberOfRooms INTEGER,
      totalPrice REAL,
      paymentMethod TEXT,
      date TEXT,
      FOREIGN KEY (userId) REFERENCES users(id)  
    )
  ''');

    await db.execute('''
    CREATE TABLE food_transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER, 
      food TEXT,
      quantity INTEGER,
      totalPrice REAL,
      paymentMethod TEXT,
      date TEXT,
      FOREIGN KEY (userId) REFERENCES users(id) 
    )
  ''');
  }

  // Menyimpan user ke dalam database
  Future<int> insertUser(RegisterModel register) async {
    var db = await database;
    return await db.insert('users', register.toMap());
  }

  // Mengambil user berdasarkan username
  Future<UserModel?> getUserByUsername(String username) async {
    var db = await database;
    var result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  // Cek apakah username atau email sudah terdaftar
  Future<bool> isUsernameOrEmailTaken(String username, String email) async {
    var db = await database;
    var usernameResult = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    var emailResult = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return usernameResult.isNotEmpty || emailResult.isNotEmpty;
  }

  Future<bool> checkUserCredentials(String username, String password) async {
    var db = await database;
    var result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }

  // Update data user
  Future<int> updateUser(UserModel user) async {
    var db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Hapus user berdasarkan id
  Future<int> deleteUser(int id) async {
    var db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // HOTEL
  Future<void> addTransactionHotel(TransactionHotelModel transaction) async {
    var db = await database;

    await db.insert('hotel_transactions', {
      'userId': transaction.userId,
      'hotel': jsonEncode(transaction.hotel.toMap()),
      'numberOfRooms': transaction.numberOfRooms,
      'totalPrice': transaction.totalPrice,
      'paymentMethod': transaction.paymentMethod,
      'date': transaction.date.toIso8601String(),
    });
  }

  Future<List<TransactionHotelModel>> getTransactionsHotelByUserId(int userId) async {
    var db = await database;
    var result = await db.query(
      'hotel_transactions',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return result.isNotEmpty ? result.map((e) => TransactionHotelModel.fromMap(e)).toList() : [];
  }

  // FOOD
  Future<void> addTransactionFood(TransactionFoodModel transaction) async {
    var db = await database;

    await db.insert('food_transactions', {
      'userId': transaction.userId,
      'food': jsonEncode(transaction.food.toMap()),
      'quantity': transaction.quantity,
      'totalPrice': transaction.totalPrice,
      'paymentMethod': transaction.paymentMethod,
      'date': transaction.date.toIso8601String(),
    });
  }

  Future<List<TransactionFoodModel>> getTransactionsFoodByUserId(int userId) async {
    var db = await database;
    var result = await db.query(
      'food_transactions',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return result.isNotEmpty ? result.map((e) => TransactionFoodModel.fromMap(e)).toList() : [];
  }
}
