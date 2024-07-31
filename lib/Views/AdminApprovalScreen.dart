// admin_approval_screen.dart
import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/SQLite/db_helper.dart';

class AdminApprovalScreen extends StatefulWidget {
  @override
  _AdminApprovalScreenState createState() => _AdminApprovalScreenState();
}

class _AdminApprovalScreenState extends State<AdminApprovalScreen> {
  List<Map<String, dynamic>> _questions = [];

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  void _fetchQuestions() async {
    var dbHelper = DBHelper();
    List<Map<String, dynamic>> questions = await dbHelper.fetchQuestions();
    setState(() {
      _questions = questions;
    });
  }

  void _deleteQuestion(int id) async {
    var dbHelper = DBHelper();
    await dbHelper.deleteQuestion(id);
    _fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Approval'),
      ),
      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          final question = _questions[index];
          return ListTile(
            title: Text(question['question']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteQuestion(question['id']),
            ),
          );
        },
      ),
    );
  }
}
