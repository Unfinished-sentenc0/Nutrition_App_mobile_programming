import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'faq.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY,
        question TEXT,
        answer TEXT
      )
    ''');
  }

  Future<int> insertQuestion(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('questions', row);
  }

  Future<List<Map<String, dynamic>>> fetchQuestions() async {
    Database db = await database;
    return await db.query('questions');
  }

  Future<int> deleteQuestion(int id) async {
    Database db = await database;
    return await db.delete('questions', where: 'id = ?', whereArgs: [id]);
  }
}