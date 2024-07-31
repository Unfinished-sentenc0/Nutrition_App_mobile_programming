import 'package:flutter/material.dart';
// Import the login screen for users
import 'package:sqlite_flutter_crud/Authtentication/NutritionistLogin .dart'; // Import the login screen for nutritionists
import 'package:sqlite_flutter_crud/Authtentication/Adminlogin.dart'; // Import the login screen for admin
import 'package:sqlite_flutter_crud/Authtentication/Usersignup.dart';
import 'package:sqlite_flutter_crud/SQLite/DatabaseHelper.dart';
import 'package:sqlite_flutter_crud/Views/user_home_screen.dart';  // Import the user signup screen
 // Import the nutritionist signup screen

class InitialUserLogin extends StatefulWidget {
  @override
  _InitialUserLoginState createState() => _InitialUserLoginState();
}

class _InitialUserLoginState extends State<InitialUserLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  void _loginUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog("Please fill all fields.");
      return;
    }

    final user = await _dbHelper.loginUser(username, password);

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/user_home_screen'); // Redirect to the user's home screen
    } else {
      _showErrorDialog("Invalid username or password.");
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
                    "User Log In",
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
                const SizedBox(height: 10),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple,
                  ),
                  child: TextButton(
                    onPressed: _loginUser,
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserSignUp()),
                    );
                  },
                  child: Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NutritionistLogin()),
                    );
                  },
                  child: Text('Login as Nutritionist'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminLogin()),
                    );
                  },
                  child: Text('Login as Admin'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}