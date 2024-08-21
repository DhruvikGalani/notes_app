import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? database;

  Future<Database> createDatabase() async {
    // Get a location using getDatabasesPath
    var databasepath = await getDatabasesPath();
    String path = join(databasepath, 'DataBaseFlie.db');

//     open the database
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE dbTable (id INTEGER PRIMARY KEY,heading text , desc text, date text)');
      },
    );
    return database!;
  }
}
