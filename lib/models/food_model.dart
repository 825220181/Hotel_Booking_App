class FoodModel {
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final double price;

  FoodModel({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'price': price,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      rating: map['rating'],
      price: map['price'],
    );
  }
}

List<FoodModel> sampleFoods = [
  FoodModel(
    name: 'Ayam Goreng',
    description: 'Ayam goreng renyah dengan bumbu khas yang menggugah selera.',
    imageUrl: 'assets/images/ayam_goreng.jpeg',
    rating: 4.5,
    price: 25000.0,
  ),
  FoodModel(
    name: 'Nasi Goreng',
    description: 'Nasi goreng dengan rasa pedas dan bumbu yang kaya, dilengkapi dengan telur dan ayam.',
    imageUrl: 'assets/images/nasi_goreng.jpeg',
    rating: 4.8,
    price: 30000.0,
  ),
  FoodModel(
    name: 'Nasi Uduk',
    description: 'Nasi uduk dengan aroma harum santan, disajikan dengan lauk yang menggugah selera.',
    imageUrl: 'assets/images/nasi_uduk.jpeg',
    rating: 4.0,
    price: 28000.0,
  ),
  FoodModel(
    name: 'Bakso Bakar',
    description: 'Bakso bakar yang disajikan dengan sambal pedas dan saus manis yang nikmat.',
    imageUrl: 'assets/images/bakso_bakar.jpeg',
    rating: 4.3,
    price: 35000.0,
  ),
  FoodModel(
    name: 'Sate Padang',
    description: 'Sate daging sapi dengan kuah kacang khas Padang yang pedas dan gurih.',
    imageUrl: 'assets/images/sate_padang.jpeg',
    rating: 4.7,
    price: 40000.0,
  ),
  FoodModel(
    name: 'Teh Manis',
    description: 'Teh manis dengan rasa segar yang menyegarkan dahaga.',
    imageUrl: 'assets/images/teh_manis.jpeg',
    rating: 4.2,
    price: 8000.0,
  ),
  FoodModel(
    name: 'Lemon Tea',
    description: 'Minuman teh dengan perasan lemon yang asam dan segar.',
    imageUrl: 'assets/images/lemon_tea.jpeg',
    rating: 4.1,
    price: 10000.0,
  ),
  FoodModel(
    name: 'Jus Jeruk',
    description: 'Jus jeruk segar dengan rasa manis alami dari buah jeruk.',
    imageUrl: 'assets/images/jus_jeruk.jpeg',
    rating: 4.6,
    price: 15000.0,
  ),
  FoodModel(
    name: 'Jus Alpukat',
    description: 'Jus alpukat kental dengan rasa lezat dan creamy, cocok untuk dinikmati kapan saja.',
    imageUrl: 'assets/images/jus_alpukat.jpeg',
    rating: 4.4,
    price: 18000.0,
  ),
  FoodModel(
    name: 'Kopi',
    description: 'Kopi hitam pekat yang memberikan rasa hangat dan penuh energi.',
    imageUrl: 'assets/images/kopi.jpeg',
    rating: 4.9,
    price: 12000.0,
  ),
];
