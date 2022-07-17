import 'package:flutter_sqlite_sample/db/database-helper.dart';
import 'package:flutter_sqlite_sample/model/dog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DogViewModel {
  Future<void> insertDog(Dog dog) async {
    Database db = await DatabaseHelper.instance.database;
    await db.insert('dogs', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map>> getData() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.rawQuery('SELECT * FROM dogs');
    return result;
  }

  Future<void> updateDog(Map<String, dynamic> dog, int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update('dogs', dog, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteDog(int id) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }
}
