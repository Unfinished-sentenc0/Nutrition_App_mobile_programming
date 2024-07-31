import 'package:flutter/material.dart';
import 'package:sqlite_flutter_crud/SQLite/db_helper.dart';

class AddQuestionScreen extends StatefulWidget {
  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  void _addQuestion() async {
    if (_questionController.text.isNotEmpty && _answerController.text.isNotEmpty) {
      var dbHelper = DBHelper();
      await dbHelper.insertQuestion({
        'question': _questionController.text,
        'answer': _answerController.text,
      });
      // Make sure this is called only when you want to go back
      Navigator.pop(context);
    } else {
      // Optionally, show an error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                labelText: 'Answer',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addQuestion,
              child: Text('Add Question'),
            ),
          ],
        ),
      ),
    );
  }
}
