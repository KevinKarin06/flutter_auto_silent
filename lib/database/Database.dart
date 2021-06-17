import 'package:autosilentflutter/Constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocationDatabase {
  static Database _database;
  Future<Database> getDatabase() async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), Constants.DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute('''CREATE TABLE ${Constants.TABLE_NAME}
            (id INTEGER PRIMARY KEY, latitude INTEGER, 
            longitude INTEGER, title TEXT, subtitle TEXT NOT NULL, uuid TEXT)''');
      },
      version: 1,
    );
  }
}
