import 'dart:io';

import 'package:news/src/models/ItemModel.dart';
import 'package:news/src/resources/Repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items6.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              url TEXT,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      'items',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      'items',
      item.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<int> clear() {
    return db.delete('items');
  }
}

final newsDbProvider = NewsDbProvider();
