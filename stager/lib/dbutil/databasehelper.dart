/*
  DatabaseHelper
  Version 0.0.1
*/

import 'dart:async';

import '../model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableNote = 'disProducts';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnDescription = 'description';


  // The .internal() method and the factory are all part of the mechanism
  // for singletons in Dart.
  DatabaseHelper.internal();

  // Singleton pattern
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'dis.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnDescription TEXT)');
  }

  Future<int> saveNote(Note note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNote, note.toMap());
    return result;
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient
        .query(tableNote, columns: [columnId, columnTitle, columnDescription]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }

  Future<Note> getNote(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, columnTitle, columnDescription],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new Note.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
  }

  /*
    Delete all records form the given table
  */
  Future<int> deleteAll(String tableName) async {
    var dbClient = await db;
    print("Deleted Deleted Deleted");
    return await dbClient.rawDelete("DELETE FROM $tableName");
  }

  Future<int> updateNote(Note note) async {
    var dbClient = await db;
    return await dbClient.update(tableNote, note.toMap(),
        where: "$columnId = ?", whereArgs: [note.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
