class RegisterModel {
  String username;
  String email;
  String password;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}
