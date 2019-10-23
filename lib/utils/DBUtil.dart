//Created by 1vPy on 2019/10/22.
import 'dart:async';

import 'package:bkapp_flutter/entity/movie/results.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBUtil {
  static final DBUtil _instance = new DBUtil.internal();

  factory DBUtil() => _instance;

  static final String tableMovie = 'MovieTable';
  static final String columnId = 'id';
  static final String vote_count = 'vote_count';
  static final String vote_average = 'vote_average';
  static final String title = 'title';
  static final String popularity = 'popularity';
  static final String poster_path = 'poster_path';
  static final String original_language = 'original_language';
  static final String original_title = 'original_title';
  static final String genre_ids = 'genre_ids';
  static final String backdrop_path = 'backdrop_path';
  static final String release_date = 'release_date';

  final String createTable =
      'CREATE TABLE $tableMovie($columnId INTEGER PRIMARY KEY'
      ', $vote_count INTEGER'
      ', $vote_average DOUBLE'
      ', $title TEXT'
      ', $popularity DOUBLE'
      ', $poster_path TEXT'
      ', $original_language TEXT'
      ', $original_title TEXT'
      ', $genre_ids TEXT'
      ', $backdrop_path TEXT'
      ', $release_date TEXT)';

  static Database _db;

  DBUtil.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'movie.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(createTable);
  }

  Future<int> insertMovie(Results movie) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableMovie, movie.toSqlJson());

    return result;
  }

  Future<List> selectMovies({int limit, int offset}) async {
    var dbClient = await db;
    var result = await dbClient.query(
      tableMovie,
      columns: [
        columnId,
        vote_count,
        vote_average,
        title,
        popularity,
        poster_path,
        original_language,
        original_title,
        genre_ids,
        backdrop_path,
        release_date
      ],
      limit: limit,
      offset: offset,
    );
    List<Results> movies = [];
    result.forEach((item) => movies.add(Results.fromJsonMap(item)));
    return movies;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableMovie'));
  }

  Future<Results> getMovie(int movieId) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableMovie,
        columns: [
          columnId,
          vote_count,
          vote_average,
          title,
          popularity,
          poster_path,
          original_language,
          original_title,
          genre_ids,
          backdrop_path,
          release_date
        ],
        where: '$columnId = ?',
        whereArgs: [movieId]);

    if (result.length > 0) {
      return Results.fromJsonMap(result.first);
    }

    return null;
  }

  Future<int> deleteMovie(int movieId) async {
    var dbClient = await db;
    return await dbClient.delete(
        tableMovie, where: '$columnId = ?', whereArgs: [movieId]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
