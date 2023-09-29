// ignore_for_file: constant_identifier_names, unnecessary_null_comparison, depend_on_referenced_packages, prefer_interpolation_to_compose_strings, prefer_conditional_assignment, unused_field

import 'dart:io';
import 'package:certif_mobile_stuff/model/flow.dart';
import 'package:certif_mobile_stuff/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static DBHelper? _dbHelper;
  static Database? _database;
  static const String TABLE_USER = 'user';
  static const String TABLE_FLOW = 'flow';

  DBHelper._createObject();

  Future<Database> get database async {
    if (_database != null) return _database!;
    // if _database is null we instantiate it
    _database = await initDatabase();
    return _database!;
  }

  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'financium.db';
    var db = await openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  Future onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE_USER (id INTEGER PRIMARY KEY, username TEXT, password TEXT, email TEXT)");
    await db.execute(
        "CREATE TABLE $TABLE_FLOW (id INTEGER PRIMARY KEY, category TEXT, value INTEGER, description TEXT, date TEXT)");
  }

  // Flow
  Future<int> insertFlow(Flow flow) async {
    final db = await database;
    return await db.insert(TABLE_FLOW, flow.toMap());
  }

  Future<Flow?> getFlow(int id) async {
    final db = await database;
    var res = await db.query(TABLE_FLOW, where: "id = ?", whereArgs: [id]);
    Flow? list = res.isNotEmpty ? Flow.fromMap(res.first) : null;
    return list;
  }

  Future<List<Flow>> getFlows() async {
    final db = await database;
    var res = await db.query(TABLE_FLOW);
    List<Flow> list =
        res.isNotEmpty ? res.map((c) => Flow.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> updateFlow(Flow flow) async {
    final db = await database;
    var res = await db.update(TABLE_FLOW, flow.toMap(),
        where: "id = ?", whereArgs: [flow.id]);
    return res;
  }

  Future<int> deleteFlow(int id) async {
    final db = await database;
    var res = await db.delete(TABLE_FLOW, where: "id = ?", whereArgs: [id]);
    return res;
  }

  // User
  Future<int> insertUser(User user) async {
    final db = await database;
    var res = await db.insert(TABLE_USER, user.toMap());
    return res;
  }

  Future<User?> getUser(int id) async {
    final db = await database;
    var res = await db.query(TABLE_USER, where: "id = ?", whereArgs: [id]);
    User? list = res.isNotEmpty ? User.fromMap(res.first) : null;
    return list;
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    var res = await db.query(TABLE_USER);
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    var res = await db.update(TABLE_USER, user.toMap(),
        where: "id = ?", whereArgs: [user.id]);
    return res;
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    var res = await db.delete(TABLE_USER, where: "id = ?", whereArgs: [id]);
    return res;
  }

  // Login
  Future<bool> login(String username, String password) async {
    final db = await database;
    var res = await db.query(TABLE_USER,
        where: "username = ? AND password = ?",
        whereArgs: [username, password]);
    User? list = res.isNotEmpty ? User.fromMap(res.first) : null;
    return true;
  }

  // update password
  Future<int> updatePassword(String email, String password) async {
    final db = await database;
    var res = await db.update(TABLE_USER, {'password': password},
        where: "email = ?", whereArgs: [email]);
    return res;
  }

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createObject();
    }
    return DBHelper._createObject();
  }

  Future<Database> get db async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database!;
  }
}
