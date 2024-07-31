import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_flutter_crud/JsonModels/Users.dart';
import 'package:sqlite_flutter_crud/JsonModels/Nutritionist_model.dart';
import 'package:sqlite_flutter_crud/JsonModels/admin.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, // Ensure this matches the version in _upgradeDB
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE nutritionists (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        email TEXT NOT NULL,
        qualificationImage TEXT NOT NULL,
        description TEXT NOT NULL,
        isApproved INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE admin (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.insert(
      'admin',
      Admin(email: 'admin@gmail.com', password: '123456').toMap(),
    );
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE nutritionists ADD COLUMN email TEXT NOT NULL
      ''');
    }
  }

  Future<int> createUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> loginUser(String username, String password) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      columns: ['id', 'username', 'password', 'email'],
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> createNutritionist(NutritionistModel nutritionist) async {
    final db = await instance.database;
    return await db.insert('nutritionists', nutritionist.toMap());
  }

  Future<NutritionistModel?> loginNutritionist(String username, String password) async {
    final db = await instance.database;
    final maps = await db.query(
      'nutritionists',
      columns: [
        'id',
        'username',
        'password',
        'email',
        'qualificationImage',
        'description',
        'isApproved'
      ],
      where: 'username = ? AND password = ? AND isApproved = 1',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      return NutritionistModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Admin?> loginAdmin(String email, String password) async {
    final db = await instance.database;
    final maps = await db.query(
      'admin',
      columns: ['id', 'email', 'password'],
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return Admin(
        id: maps.first['id'] as int?,
        email: maps.first['email'] as String,
        password: maps.first['password'] as String,
      );
    } else {
      return null;
    }
  }

  // Get all nutritionists for admin review
  

  // Update nutritionist approval status
 
  Future<List<NutritionistModel>> getAllNutritionists() async {
  final db = await instance.database;
  final List<Map<String, dynamic>> maps = await db.query('nutritionists');

  return List.generate(maps.length, (i) {
    return NutritionistModel.fromMap(maps[i]);
  });
}
Future<void> updateNutritionistApproval(int id, bool isApproved) async {
  final db = await instance.database;
  await db.update(
    'nutritionists',
    {'isApproved': isApproved ? 1 : 0},
    where: 'id = ?',
    whereArgs: [id],
  );
}


}
