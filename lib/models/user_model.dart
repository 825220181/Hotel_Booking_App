class UserModel {
  final int? id;
  final String username;
  final String email;
  final String password;

  // Konstruktor
  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  // Fungsi untuk mengubah objek User menjadi map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  // Fungsi untuk mengubah map ke objek User
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}
