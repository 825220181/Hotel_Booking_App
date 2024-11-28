class LoginModel {
  String username;
  String password;

  LoginModel({
    required this.username,
    required this.password,
  });

  // Konversi LoginModel menjadi Map untuk keperluan validasi
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  // Konversi dari Map (dari database) menjadi LoginModel
  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      username: map['username'],
      password: map['password'],
    );
  }
}