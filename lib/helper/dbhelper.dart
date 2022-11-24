import 'dart:io';

import 'package:flutter_app_test_victoria/model/review.dart';
import 'package:flutter_app_test_victoria/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "vcdb.db";
  static final _databaseVersion = 1;

  static final table = 'user_table';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnUsia = 'usia';
  static final columnGender = 'gender';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  late Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnUsia INTEGER NOT NULL,
            $columnGender TEXT NOT NULL,
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(User user) async {
    Database db = await instance.database;
    return await db.insert(
        table, {'name': user.name, 'usia': user.usia, 'gender': user.gender});
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnName LIKE '%$name%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(User user) async {
    Database db = await instance.database;
    int id = user.toMap()['id'];
    return await db
        .update(table, user.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}

class DBHelper {
  static Database? _db;
  static const String ID = 'id';
  static const String NAME = 'photoName';
  static const String USER = 'reviewName';
  static const String DATE = 'date';
  static const String NOTE = 'note';
  static const String TABLE = 'photosTable';
  static const String DB_Name = 'photos.db';

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  Future<Database?> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $TABLE ($ID INTEGER, $NAME TEXT, $USER TEXT, $DATE TEXT, $NOTE TEXT)');
  }

  Future<photo> save(photo photo) async {
    var dbClient = await db;
    print(photo.photoName);
    photo.id = await dbClient!.insert(TABLE, photo.toMap());
    print(photo.id);
    return photo;
  }

  Future<List<photo>> getPhotos() async {
    var dbClient = await db;
    List<Map> maps =
        await dbClient!.query(TABLE, columns: [ID, NAME, USER, DATE, NOTE]);
    List<photo> photos = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        photos.add(photo.fromMap(Map<String, dynamic>.from(maps[i])));
      }
    }
    print("photos {{$photos}}");
    return photos;
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
