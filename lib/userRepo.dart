import 'package:sqflite/sqflite.dart';

class UserRepo {
  void FncCreateTable(Database? db) {
    try {
      db?.execute(
          'CREATE TABLE IF NOT EXISTS USER (ID INTEGER PRIMARY KEY,name TEXT,fullname TEXT,adddress TEXT,city TEXT, email TEXT)');
    } catch (ex) {
      print(ex);
    }
    ;

    try {
      db?.transaction((l_transaction) async {
        await l_transaction.rawQuery("PRAGMA foreign_keys = 0;");

        await l_transaction.rawQuery(
            "CREATE TABLE sqlitestudio_temp_table AS SELECT * FROM USER");

        await l_transaction.rawQuery("DROP TABLE USER");

        await l_transaction.rawQuery(
            "CREATE TABLE USER (id INTEGER PRIMARY KEY,name TEXT UNIQUE,adddress TEXT,city TEXT,email TEXT)");

        await l_transaction.rawQuery(
            "INSERT INTO USER (id,name,adddress,city,email)SELECT id,name,adddress,city,email FROM sqlitestudio_temp_table");

        await l_transaction.rawQuery("DROP TABLE sqlitestudio_temp_table");

        await l_transaction.rawQuery("PRAGMA foreign_keys = 1");
      });
    } catch (ex) {
      print(ex);
    }
    ;
  }

  Future<List<Map<String, dynamic>>> FncGetDataDB(Database? db) async {
    final List<Map<String, dynamic>> maps = await db!.query('User');
    print(maps);
    return maps;
  }
}
