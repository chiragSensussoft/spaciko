import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDbProvider{

  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async{
    return _database != null? _database = await intDB() : _database;
  }

  intDB() async{
    Directory documentsDirectory = await
    getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,"ProductDB.db");
    return await openDatabase(path
    ,version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async{
        await db.execute(
            "CREATE TABLE Product ("
                "id INTEGER PRIMARY KEY,"
                "fName TEXT,"
                "lName TEXT,"
                "email TEXT,"
                "password TEXT,"
                "isLoginWith TEXT"")"
        );
        await db.execute("INSERT INTO Product ('id', 'fName', 'lName', 'email', 'password','isLoginWith')"
            "values (?, ?, ?, ?, ?)", [1, "iPhone", "iPhone is the stylist phone ever", 1000, "iphone.png"]
        );
      }
    );
  }

}