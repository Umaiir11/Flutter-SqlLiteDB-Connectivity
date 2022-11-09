import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


//DB skeleton Class
class DatabaseHelper {
  static final DatabaseHelper Db_helper = DatabaseHelper._internal();

  static Database? _database;
  DatabaseHelper._internal();


  factory DatabaseHelper(){
    return Db_helper;
  }

  Future<Database?> openDB() async {
      Directory dt = await getApplicationDocumentsDirectory();
      print('db location :'+dt.path);
    _database = await openDatabase(join(await getDatabasesPath(), 'DB5.db'));
    return _database;
  }
}
