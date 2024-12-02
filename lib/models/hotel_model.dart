import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HotelModel {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int guests;
  int rooms;

  HotelModel({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.checkInDate,
    this.checkOutDate,
    this.guests = 2,
    this.rooms = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'checkInDate': checkInDate?.toIso8601String(),
      'checkOutDate': checkOutDate?.toIso8601String(),
      'guests': guests,
      'rooms': rooms,
    };
  }

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    return HotelModel(
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      checkInDate: map['checkInDate'] != null ? DateTime.parse(map['checkInDate']) : null,
      checkOutDate: map['checkOutDate'] != null ? DateTime.parse(map['checkOutDate']) : null,
      guests: map['guests'] ?? 2,
      rooms: map['rooms'] ?? 1,
    );
  }
}

List<HotelModel> sampleHotels = [
  HotelModel(
    name: 'Standard Room',
    description: 'A cozy and budget-friendly room for your stay.',
    imageUrl: 'assets/images/room_1.jpeg',
    price: 800000.0,
  ),
  HotelModel(
    name: 'Superior Room',
    description: 'A comfortable room with a beautiful city view.',
    imageUrl: 'assets/images/room_2.jpeg',
    price: 1200000.0,
  ),
  HotelModel(
    name: 'Standard Room',
    description: 'A cozy and budget-friendly room for your stay.',
    imageUrl: 'assets/images/room_3.jpeg',
    price: 8000000.0,
  ),
  HotelModel(
    name: 'Superior Room',
    description: 'A comfortable room with a beautiful city view.',
    imageUrl: 'assets/images/room_4.jpeg',
    price: 1500000.0,
  )
];

class HotelListPage extends StatelessWidget {
  const HotelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hotel Booking')),
      body: ListView.builder(
        itemCount: sampleHotels.length,
        itemBuilder: (context, index) {
          final hotel = sampleHotels[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(
                hotel.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(hotel.name),
              subtitle: Text('Rp. ${hotel.price.toStringAsFixed(0)}/night'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotelDetailPage(hotel: hotel),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class HotelDetailPage extends StatefulWidget {
  final HotelModel hotel;

  const HotelDetailPage({super.key, required this.hotel});

  @override
  _HotelDetailPageState createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _rooms = 1;
  int _adults = 2;
  int _children = 0;

  @override
  Widget build(BuildContext context) {
    int totalNights = _checkOutDate != null && _checkInDate != null
        ? _checkOutDate!.difference(_checkInDate!).inDays
        : 0;

    double totalPrice = totalNights * widget.hotel.price * _rooms;

    return Scaffold(
      appBar: AppBar(title: Text(widget.hotel.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(widget.hotel.imageUrl, fit: BoxFit.cover),
              const SizedBox(height: 16),
              Text(
                widget.hotel.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Rp. ${widget.hotel.price.toStringAsFixed(0)}/night',
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Check-in Date:'),
                  TextButton(
                    onPressed: () => _pickDate(context, isCheckIn: true),
                    child: Text(
                      _checkInDate != null
                          ? DateFormat('EEE, dd MMM yyyy').format(_checkInDate!)
                          : 'Select Date',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Check-out Date:'),
                  TextButton(
                    onPressed: () => _pickDate(context, isCheckIn: false),
                    child: Text(
                      _checkOutDate != null
                          ? DateFormat('EEE, dd MMM yyyy').format(_checkOutDate!)
                          : 'Select Date',
                    ),
                  ),
                ],
              ),
              if (totalNights > 0)
                Text('$totalNights night(s)', style: const TextStyle(fontSize: 16)),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Rooms:'),
                  DropdownButton<int>(
                    value: _rooms,
                    items: List.generate(
                      5,
                          (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text('${index + 1} Room'),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _rooms = value!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Adults:'),
                  DropdownButton<int>(
                    value: _adults,
                    items: List.generate(
                      5,
                          (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text('${index + 1} Adult(s)'),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _adults = value!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Children:'),
                  DropdownButton<int>(
                    value: _children,
                    items: List.generate(
                      5,
                          (index) => DropdownMenuItem(
                        value: index,
                        child: Text('$index Child(ren)'),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _children = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_checkInDate != null && _checkOutDate != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Booking confirmed for $_rooms room(s), $_adults adult(s), $_children child(ren)'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select dates.')),
                    );
                  }
                },
                child: Text(
                  'Book Now (Rp. ${totalPrice.toStringAsFixed(0)})',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context, {required bool isCheckIn}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          _checkOutDate = picked.add(const Duration(days: 1)); // Default next day
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }
}

// Main
void main() {
  runApp(const MaterialApp(
    home: HotelListPage(),
    debugShowCheckedModeBanner: false,
  ));
}
