import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/SQLite/db_helper.dart';
import 'package:sqlite_flutter_crud/Views/message.dart';
import 'package:sqlite_flutter_crud/Views/profilescreen.dart';
import 'package:sqlite_flutter_crud/Views/helpscreen.dart';
import 'package:sqlite_flutter_crud/Views/donate_page.dart'; // Import DonatePage

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _questions = [];
  List<Map<String, dynamic>> _filteredQuestions = [];

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    _searchController.addListener(() {
      _filterQuestions(_searchController.text);
    });
  }

  void _fetchQuestions() async {
    var dbHelper = DBHelper();
    List<Map<String, dynamic>> questions = await dbHelper.fetchQuestions();
    setState(() {
      _questions = questions;
      _filteredQuestions = questions;
    });
  }

  void _filterQuestions(String query) {
    final filtered = _questions.where((question) {
      final questionText = question['question'].toString().toLowerCase();
      return questionText.contains(query.toLowerCase());
    }).toList();
    setState(() {
      _filteredQuestions = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/', // Navigate to the login screen
              (Route<dynamic> route) => false, // Remove all previous routes
            );
          },
        ),
        title: Text('Healthy Diet App'),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer menu
                },
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Navigation Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserHomeScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Messages'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Donate'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonatePage()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue[50], // Light blue background color
        selectedItemColor: Colors.blue, // Color for the selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money), // Donate icon
            label: 'Donate',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UserHomeScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DonatePage()),
              );
              break;
          }
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterQuestions,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredQuestions.length,
              itemBuilder: (context, index) {
                final question = _filteredQuestions[index];
                return ListTile(
                  title: Text(question['question']),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(question['question']),
                        content: Text(question['answer']),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
