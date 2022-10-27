// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/article_model.dart';

class ArticleDatabase {
  static ArticleDatabase? instance;

  factory ArticleDatabase() {
    instance ??= ArticleDatabase._createInstance();
    return instance!;
  }

  ArticleDatabase._createInstance();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('articles.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    print(dbPath);
    final path = join(dbPath.path, filePath);
    var db = await openDatabase(path, version: 1, onCreate: _createDB);
    return db;
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    await db.execute(
        "CREATE TABLE $articlesTable (${ArticleFields.id} $idType, ${ArticleFields.source} $textType, ${ArticleFields.author} $textType, ${ArticleFields.title} $textType, ${ArticleFields.description} $textType, ${ArticleFields.url} $textType, ${ArticleFields.urlToImage} $textType, ${ArticleFields.publishedAt} $textType,${ArticleFields.content} $textType)");
  }

  Future<ArticleModel> insert(ArticleModel data) async {
    final db = await database;
    data.id = await db.insert(articlesTable, data.toJsonForDb());
    return data;
  }

  Future<List<ArticleModel>> readAll() async {
    final db = await database;

    final result = await db.rawQuery('SELECT * FROM $articlesTable');

    return result.map((json) => ArticleModel.fromJsonForDb(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await database;
    int count =
        await db.rawDelete('DELETE FROM $articlesTable WHERE id = ?', [id]);
    return count;
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.execute("delete from $articlesTable");
  }

  Future close() async {
    final db = await instance!.database;
    db.close();
  }
}

const String articlesTable = 'articles_table';

class ArticleFields {
  static const String id = 'id';
  static const String source = 'source';
  static const String author = 'author';
  static const String title = 'title';
  static const String description = 'description';
  static const String url = 'url';
  static const String urlToImage = 'urlToImage';
  static const String publishedAt = 'publishedAt';
  static const String content = 'content';
}
