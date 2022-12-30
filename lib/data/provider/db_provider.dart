import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pokedex/domain/entities/pokemon_list.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the User table
  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'pokemon_manager.db');
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Pokemon(id INTEGER PRIMARY KEY, name TEXT NOT NULL, url TEXT NOT NULL)",
          );

        });
  }

  // Insert user on database
  createPokemons(Results pokemons) async {
    // final userid = newUser.id;
    final name = pokemons.name;
    final url = pokemons.url;
    await deleteAllPokemon();
    final db = await database;
    final res = await db.rawInsert('''
    INSERT INTO Pokemon (name, url)
    VALUES('$name', '$url')
    ''');

    return res;
  }

  // Delete all users
  Future<int> deleteAllPokemon() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Pokemon');

    return res;
  }

  // Get all users
  Future<List<Results>> getAllPokemon() async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM Pokemon');

    List<Results> list =
    res.isNotEmpty ? res.map((c) => Results.fromJson(c)).toList() : [];

    return list;
  }

// Filter users via name
  Future<List<Results>> searchPokemons(String keyword) async {
    final db = await database;

    List<Map<String, dynamic>> allRows = await db
        .query('Pokemon', where: 'name LIKE ?', whereArgs: ['%$keyword%']);

    List<Results> list =
    allRows.isNotEmpty ? allRows.map((c) => Results.fromJson(c)).toList() : [];

    return list;

  }
}
