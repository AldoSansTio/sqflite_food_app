import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import '../data/Food.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const _databaseName = "food.db";
  static const _databaseVersion = 1;

  static const tableName = "food";

  static const columnId = 'id';
  static const columnNama = 'nama';
  static const columnWaktuPembuatan = 'waktuPembuatan';
  static const columnDeskripsi = 'deskripsi';
  static const columnJenis = 'jenis';
  static const columnImages = 'images';
  static const columnResep = 'resep';

  Database? _database;

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, _databaseName);
    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
    return _database!;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnNama TEXT NOT NULL,
        $columnWaktuPembuatan INTEGER NOT NULL,
        $columnDeskripsi TEXT NOT NULL,
        $columnJenis TEXT NOT NULL,
        $columnImages TEXT NOT NULL,
        $columnResep TEXT NOT NULL
      );
  ''');
  }

  Future<void> insertFood(Food food) async {
    final db = await database;
    await db.insert(
      tableName,
      food.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateFood(Food food) async {
    final db = await database;

    await db.update(
      tableName,
      food.toJson(),
      where: '$columnId == ?',
      whereArgs: [food.id],
    );
  }

  Future<List<Food>> queryAllRows() async {
    final db = await database;

    List<Map<String, dynamic>> foods =
        await db.query(tableName, orderBy: "$columnId DESC");
    return List.generate(
        foods.length,
        (index) => Food(
              id: foods[index]['id'],
              nama: foods[index]['nama'],
              waktuPembuatan: foods[index]['waktuPembuatan'],
              deskripsi: foods[index]['deskripsi'],
              jenis: foods[index]['jenis'],
              images: foods[index]['images'],
              resep: foods[index]['resep'],
            ));
  }

  Future<List<Food>> GetFoodByJenis(String jenis) async {
    final db = await database;

    List<Map<String, dynamic>> foods = await db.query(
      tableName,
      where: "$columnJenis == ?",
      whereArgs: [jenis],
      orderBy: "$columnId DESC",
    );
    return List.generate(
        foods.length,
        (index) => Food(
              id: foods[index]['id'],
              nama: foods[index]['nama'],
              waktuPembuatan: foods[index]['waktuPembuatan'],
              deskripsi: foods[index]['deskripsi'],
              jenis: foods[index]['jenis'],
              images: foods[index]['images'],
              resep: foods[index]['resep'],
            ));
  }

  Future<List<Food>> SearchFoodByName(String name) async {
    final db = await database;

    List<Map<String, dynamic>> foods = await db.query(
      tableName,
      where: "$columnNama LIKE '?'",
      whereArgs: ['%$name%'],
      orderBy: "$columnId DESC",
    );
    return List.generate(
        foods.length,
        (index) => Food(
              id: int.parse(foods[index]['id']),
              nama: foods[index]['nama'].toString(),
              waktuPembuatan: int.parse(foods[index]['waktuPembuatan']),
              deskripsi: foods[index]['deskripsi'].toString(),
              jenis: foods[index]['jenis'].toString(),
              images: foods[index]['images'].toString(),
              resep: foods[index]['resep'].toString(),
            ));
  }

  Future<Food> getById(int id) async {
    final db = await database;

    List<Map<String, dynamic>> foods = await db.query(
      tableName,
      where: "$columnId == ?",
      whereArgs: [id],
    );
    return Food(
      id: foods[0]['id'],
      nama: foods[0]['nama'],
      waktuPembuatan: foods[0]['waktuPembuatan'],
      deskripsi: foods[0]['deskripsi'],
      jenis: foods[0]['jenis'],
      images: foods[0]['images'],
      resep: foods[0]['resep'],
    );
  }

  Future<void> deleteFood(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: '$columnId == ?',
      whereArgs: [id],
    );
  }

  clearTable() async {
    final db = await database;
    return await db.rawQuery("DELETE FROM $tableName");
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
