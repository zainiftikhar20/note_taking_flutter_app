import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



// ignore: camel_case_types
class DB_Helper {
  static Future database() async {
    final databasePath = await getDatabasesPath();
    return openDatabase(join(databasePath, 'notes_database.db'),
        onCreate: (database, version) {
          return database.execute(
              'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT, imagePath TEXT)');
        }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> getNotesFromDB() async {
    final database = await DB_Helper.database();
    return database.query("notes", orderBy: "id DESC");
  }

  static Future delete(int id) async {
    final database = await DB_Helper.database();
    return database.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
  static Future insert(Map<String, Object> data) async {
    final database = await DB_Helper.database();
    database.insert("notes", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
