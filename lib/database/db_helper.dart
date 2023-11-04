
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tmdbassignment/models/DbModel.dart';

import '../models/TMDBModel.dart';

class CacheDatabaseHelper{

  CacheDatabaseHelper._privateConstructor();

  static final CacheDatabaseHelper instance = CacheDatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async{
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/CacheDatabase.db';
    var favDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
    return favDatabase;
  }
  void _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const textTypeUnique = 'TEXT UNIQUE';


    await db.execute('''
    CREATE TABLE $cacheDbTable(
    ${DbFields.id} $idType,
    ${DbFields.movie_id} $textTypeUnique,
    ${DbFields.original_title} $textType,
    ${DbFields.overview} $textType,
    ${DbFields.poster_path} $textType,
    ${DbFields.release_date} $textType,
    ${DbFields.genre_names} $textType)
    ''');
  }

  Future<int> addData(DbModel dbModel) async {
    Database db = await instance.database;
    int result = await db.insert(cacheDbTable, dbModel.toJson());
    return result;
  }

  Future<List<DbModel>> readAllData() async {
    final db = await instance.database;
    // var orderBy = '${BooksFields.modifiedTime} $order';
    final result = await db.query(cacheDbTable);
    return result.map((json) => DbModel.fromJson(json)).toList();
  }

  Future<int> deleteAllData() async {
    final db = await instance.database;
    return await db.delete(cacheDbTable);
  }

}

