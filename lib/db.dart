import 'dart:async';
import 'info.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {

  Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'sinfo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE infos(id INTEGER PRIMARY KEY, date TEXT, title TEXT, url TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertInfo(Info info) async {
    final Database db = await _getDB();

    await db.insert(
      'infos',
      info.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Info>> infos({String date : ''}) async {
    final Database db = await _getDB();

    List<Map<String, dynamic>> maps;
    if (date == '') {
      maps = await db.query('infos');
    } else {
      maps = await db.query(
          'infos',
        where: "date = ?",
        whereArgs: [date]
      );
    }

    return List.generate(maps.length, (i) {
      return Info(
        maps[i]['id'],
        maps[i]['date'],
        maps[i]['title'],
        maps[i]['url'],
      );
    });
  }

  Future<void> updateInfo(Info info) async {
    final db = await _getDB();

    await db.update(
      'infos',
      info.toJson(),
      where: "id = ?",
      whereArgs: [info.id],
    );
  }

  Future<void> deleteInfo(int id) async {
    final db = await _getDB();

    await db.delete(
      'infos',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
