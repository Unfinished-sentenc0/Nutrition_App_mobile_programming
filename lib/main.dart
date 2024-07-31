import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/Authtentication/InitialUserLogin.dart'; // Import the login screen for users
import 'package:sqlite_flutter_crud/Authtentication/NutritionistLogin .dart'; // Import the login screen for nutritionists
import 'package:sqlite_flutter_crud/Authtentication/Adminlogin.dart'; // Import the login screen for admin
import 'package:sqlite_flutter_crud/Authtentication/Usersignup.dart'; // Import the user signup screen
import 'package:sqlite_flutter_crud/Authtentication/Nutritionistsignup.dart';
import 'package:sqlite_flutter_crud/Views/NutritionistHomeScreen.dart';
import 'package:sqlite_flutter_crud/Views/userHome.dart';
import 'package:sqlite_flutter_crud/Views/user_home_screen.dart';
import 'package:sqlite_flutter_crud/Views/AdminApprovalScreen.dart';
import 'package:sqlite_flutter_crud/Views/message.dart';
// Import the nutritionist signup screen


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Diet App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InitialUserLogin(),
        '/login_nutritionist': (context) => NutritionistLogin(),
        '/login_admin': (context) => AdminLogin(),
        '/signup_user': (context) => UserSignUp(),
        '/signup_nutritionist': (context) => NutritionistSignUp(),
        '/userHome':(context) => ProfileViewScreen(),
        '/user_home_screen' : (context) => UserHomeScreen(),
        '/nutritionist_home' : (context) => AddQuestionScreen(),
        '/adminHome' : (context) => AdminApprovalScreen(),
         '/messages' : (context) => ChatScreen()
      },
    );
  }
}
