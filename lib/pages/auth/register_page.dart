import 'package:flutter/material.dart';
import 'package:hotel_booking_app/core/colors.dart';
import 'package:hotel_booking_app/database/database_helper.dart';
import 'package:hotel_booking_app/models/register_model.dart';
import 'package:hotel_booking_app/pages/widgets/buttons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Fungsi untuk mendaftar user
  _registerUser(context) async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Validasi form
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showDialog('Please fill all fields');
      return;
    }

    // Validasi format email
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      _showDialog('Invalid email format');
      return;
    }

    // Cek apakah username atau email sudah terdaftar
    bool isTaken = await DatabaseHelper().isUsernameOrEmailTaken(username, email);
    if (isTaken) {
      _showDialog('Username or Email is already taken');
      return;
    }

    // Membuat objek RegisterModel
    RegisterModel user = RegisterModel(
      username: username,
      email: email,
      password: password,
    );

    // Menyimpan data user ke dalam database
    await DatabaseHelper().insertUser(user);

    // Menampilkan pesan sukses dan mengarahkan ke halaman login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Berhasil Register, Silahkan Login'),
      ),
    );
    Navigator.pop(context);
  }

  // Menampilkan dialog
  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Registration'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(
            height: 40.0,
          ),
          const Center(
            child: Text(
              'Register',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
          ),
          const SizedBox(height: 40),
          Button.filled(
            onPressed: () async {
              await _registerUser(context);
            },
            label: 'Register',
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Already have an account? Login'),
          ),
        ],
      ),
    );
  }
}
