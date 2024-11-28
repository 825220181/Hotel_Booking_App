import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

// Model Hotel
class HotelModel {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  DateTime? bookingDate; // Tanggal pemesanan (opsional)

  HotelModel({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.bookingDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'bookingDate': bookingDate?.toIso8601String(),
    };
  }

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    return HotelModel(
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      bookingDate: map['bookingDate'] != null
          ? DateTime.parse(map['bookingDate'])
          : null,
    );
  }
}

// Daftar hotel
List<HotelModel> sampleHotels = [
  HotelModel(
    name: 'Standard Room',
    description:
    'A cozy and budget-friendly room that provides everything you need for a pleasant stay.',
    imageUrl: 'assets/images/room_1.jpeg',
    price: 800000.0,
  ),
  HotelModel(
    name: 'Superior Room',
    description:
    'This comfortable room is equipped with modern amenities and offers a beautiful city view.',
    imageUrl: 'assets/images/room_2.jpeg',
    price: 1200000.0,
  ),
  HotelModel(
    name: 'Deluxe Room',
    description:
    'A spacious and luxurious room featuring a king-sized bed and a panoramic ocean view.',
    imageUrl: 'assets/images/room_3.jpeg',
    price: 1500000.0,
  ),
  HotelModel(
    name: 'Suite Room',
    description:
    'Experience the height of luxury with a separate living area and upscale furnishings.',
    imageUrl: 'assets/images/room_4.jpeg',
    price: 2000000.0,
  ),
];

// Halaman Daftar Hotel
class HotelListPage extends StatelessWidget {
  const HotelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Booking'),
      ),
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
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 60);
                },
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

// Halaman Detail Hotel
class HotelDetailPage extends StatefulWidget {
  final HotelModel hotel;

  const HotelDetailPage({super.key, required this.hotel});

  @override
  _HotelDetailPageState createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotel.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.hotel.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.broken_image, size: 200),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hotel.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp. ${widget.hotel.price.toStringAsFixed(0)}/night',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(widget.hotel.description),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Booking Date:",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _selectedDate == null
                            ? "Tap to select a date"
                            : DateFormat('dd MMMM yyyy').format(_selectedDate!),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: _pickDate,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_selectedDate != null) {
                        setState(() {
                          widget.hotel.bookingDate = _selectedDate;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Hotel booked for ${DateFormat('dd MMMM yyyy').format(_selectedDate!)}"),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please select a booking date."),
                        ));
                      }
                    },
                    child: Text(
                      "Book Now (Rp. ${widget.hotel.price.toStringAsFixed(0)})",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
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
