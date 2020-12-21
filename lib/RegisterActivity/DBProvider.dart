import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "tbl_User1.db";
  static final _databaseVersion = 1;

  static final table = 'User_table';

  static final columnId = '_id';
  static final columnfName = 'fName';
  static final columnlName = 'lName';
  static final columnEmail = 'email';
  static final columnPassword = 'password';
  static final columnIsLoginWith= 'isLoginWith';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnfName TEXT NOT NULL,$columnlName TEXT NOT NULL, $columnEmail TEXT NOT NULL UNIQUE, $columnPassword TEXT, $columnIsLoginWith TEXT NOT NULL)");
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Future<int> queryRowCount() async {
  //   Database db = await instance.database;
  //   return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  // }

  Future<int> update(Map<String, dynamic> row,int id) async {
    Database db = await instance.database;
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String,dynamic>>> select(String email) async {
    Database db = await instance.database;
    List<Map> maps = await db.rawQuery("SELECT * FROM $table WHERE $columnEmail = '$email'");
    return maps;
  }

  // Future<int> delete(int id) async {
  //   Database db = await instance.database;
  //   return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  // }

}