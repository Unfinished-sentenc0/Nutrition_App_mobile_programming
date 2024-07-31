import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/JsonModels/Users.dart';
import 'package:sqlite_flutter_crud/SQLite/DatabaseHelper.dart';
 // Adjust import path

class UserSignUp extends StatefulWidget {
  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  void _signUp() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final email = _emailController.text;

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      _showErrorDialog("Please fill all fields.");
      return;
    }

    final user = User(username: username, password: password, email: email);

    final userId = await _dbHelper.createUser(user);

    if (userId > 0) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      _showErrorDialog("Signup failed. Please try again.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ListTile(
                  title: Text(
                    "User Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple.withOpacity(.2),
                  ),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: "Username",
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple.withOpacity(.2),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple.withOpacity(.2),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      border: InputBorder.none,
                      hintText: "Email",
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple,
                  ),
                  child: TextButton(
                    onPressed: _signUp,
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
