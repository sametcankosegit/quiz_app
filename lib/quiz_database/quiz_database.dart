import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuizDatabase {
  static final QuizDatabase instance = QuizDatabase._init();

  static Database? _database;

  QuizDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('quiz_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE IF NOT EXISTS scores (
        id $idType,
        userId $textType,
        score $integerType,
        timestamp $textType
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await instance.database;
    return await db.query('scores');
  }

  Future<int> insertScore(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('scores', row);
  }

  Future<int> deleteAllScores() async {
    final db = await instance.database;
    return await db.delete('scores');
  }
}
