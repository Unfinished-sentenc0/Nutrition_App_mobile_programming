import 'package:flutter/material.dart';
// Import the user signup screen
import 'package:sqlite_flutter_crud/Authtentication/Nutritionistsignup.dart'; // Import the nutritionist signup screen
import 'package:sqlite_flutter_crud/SQLite/DatabaseHelper.dart'; // Import the database helper
// Import the nutritionist model

class NutritionistLogin extends StatefulWidget {
  @override
  _NutritionistLoginState createState() => _NutritionistLoginState();
}

class _NutritionistLoginState extends State<NutritionistLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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
                    "Nutritionist Log In",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple,
                    ),
                    child: TextButton(
                      onPressed: _login,
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
                      MaterialPageRoute(builder: (context) => NutritionistSignUp()),
                    );
                  },
                  child: Text('Sign Up as Nutritionist'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final username = _usernameController.text;
      final password = _passwordController.text;

      final nutritionist = await DatabaseHelper.instance.loginNutritionist(username, password);

      setState(() {
        _isLoading = false;
      });

      if (nutritionist != null) {
        // Login successful
        Navigator.pushReplacementNamed(context, '/nutritionist_home'); // Replace with your home screen route
      } else {
        // Login failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password'),
          ),
        );
      }
    }
  }
}
