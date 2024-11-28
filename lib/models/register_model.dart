class RegisterModel {
  String username;
  String email;
  String password;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
  });

  // Konversi RegisterModel menjadi Map untuk menyimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  // Konversi dari Map (dari database) menjadi RegisterModel
  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}
