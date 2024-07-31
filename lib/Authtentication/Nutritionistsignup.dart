import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/SQLite/DatabaseHelper.dart'; // Adjust import path
import 'package:sqlite_flutter_crud/JsonModels/Nutritionist_model.dart'; // Updated import path

class NutritionistSignUp extends StatefulWidget {
  @override
  _NutritionistSignUpState createState() => _NutritionistSignUpState();
}

class _NutritionistSignUpState extends State<NutritionistSignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _qualificationImageController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> _signUpNutritionist() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final email = _emailController.text;
    final description = _descriptionController.text;
    final qualificationImage = _qualificationImageController.text;

    if (username.isEmpty || password.isEmpty || email.isEmpty || description.isEmpty || qualificationImage.isEmpty) {
      _showErrorDialog("Please fill all fields.");
      return;
    }

    final nutritionist = NutritionistModel(
      username: username,
      password: password,
      email: email,
      description: description,
      qualificationImage: qualificationImage,
      isApproved: 1, // Default to not approved
    );

    final success = await _dbHelper.createNutritionist(nutritionist);

    if (success > 0) { // Check if the insert was successful
      Navigator.pushReplacementNamed(context, '/login_nutritionist'); // Redirect to login screen
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
      appBar: AppBar(
        title: Text("Nutritionist Sign Up"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(
                  controller: _usernameController,
                  icon: Icons.person,
                  hintText: "Username",
                ),
                _buildTextField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  hintText: "Password",
                  obscureText: true,
                ),
                _buildTextField(
                  controller: _emailController,
                  icon: Icons.email,
                  hintText: "Email",
                ),
                _buildTextField(
                  controller: _descriptionController,
                  icon: Icons.description,
                  hintText: "Brief Description",
                ),
                _buildTextField(
                  controller: _qualificationImageController,
                  icon: Icons.image,
                  hintText: "Qualification Image URL",
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
                    onPressed: _signUpNutritionist,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.deepPurple.withOpacity(.2),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: Icon(icon),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
