// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// import '../models/retailer_distributor_model.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   static Database? _database;
//
//   factory DatabaseHelper() => _instance;
//
//   DatabaseHelper._internal();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'retailer_distributor.db');
//
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE distributor_data (
//             id TEXT PRIMARY KEY,
//             type TEXT,
//             business_name TEXT,
//             business_type TEXT,
//             gst_no TEXT,
//             address TEXT,
//             pincode TEXT,
//             name TEXT,
//             mobile TEXT,
//             state TEXT,
//             city TEXT,
//             region_id TEXT,
//             area_id TEXT,
//             app_pk TEXT,
//             image TEXT,
//             bank_account_id TEXT,
//             isApproved TEXT,
//             open_time TEXT,
//             close_time TEXT,
//             parent_id TEXT,
//             is_async TEXT,
//             brands TEXT,
//             is_delete TEXT
//           )
//         ''');
//       },
//     );
//   }
//
//   Future<int> insertData(Data data) async {
//     final db = await database;
//     return await db.insert(
//       'distributor_data',
//       data.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<int> updateData(Data data) async {
//     final db = await database;
//     return await db.update(
//       'distributor_data',
//       data.toMap(),
//       where: 'id = ?',
//       whereArgs: [data.id],
//     );
//   }
//
//   Future<List<Data>> fetchAllData() async {
//     final db = await database;
//     final result = await db.query('distributor_data');
//     return result.map((map) => Data.fromMap(map)).toList();
//   }
//
//   Future<int> deleteData(String id) async {
//     final db = await database;
//     return await db.delete(
//       'distributor_data',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/retailer_distributor_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'retailer_distributor.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE distributor_data (
            id TEXT PRIMARY KEY,
            type TEXT,
            business_name TEXT,
            business_type TEXT,
            gst_no TEXT,
            address TEXT,
            pincode TEXT,
            name TEXT,
            mobile TEXT,
            state TEXT,
            city TEXT,
            region_id TEXT,
            area_id TEXT,
            app_pk TEXT,
            image TEXT,
            bank_account_id TEXT,
            isApproved TEXT,
            open_time TEXT,
            close_time TEXT,
            parent_id TEXT,
            is_async TEXT,
            brands TEXT,
            is_delete TEXT
          )
        ''');
      },
    );
  }

  // Insert data into the database
  Future<int> insertData(Data data) async {
    final db = await database;
    try {
      return await db.insert(
        'distributor_data',
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error inserting data: $e");
      return -1;
    }
  }

  // Update data in the database
  Future<int> updateData(Data data) async {
    final db = await database;
    try {
      return await db.update(
        'distributor_data',
        data.toMap(),
        where: 'id = ?',
        whereArgs: [data.id],
      );
    } catch (e) {
      print("Error updating data: $e");
      return -1;
    }
  }

  // Fetch all data from the database
  Future<List<Data>> fetchAllData() async {
    final db = await database;
    try {
      final result = await db.query('distributor_data');
      return result.map((map) => Data.fromMap(map)).toList();
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  // Delete data from the database
  Future<int> deleteData(String id) async {
    final db = await database;
    try {
      return await db.delete(
        'distributor_data',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Error deleting data: $e");
      return -1;
    }
  }

  // Delete all data (optional utility method)
  Future<int> deleteAllData() async {
    final db = await database;
    try {
      return await db.delete('distributor_data');
    } catch (e) {
      print("Error deleting all data: $e");
      return -1;
    }
  }

  Future<void> updateDataById(String id, Map<String, dynamic> updatedValues) async {
    final db = await database;
    await db.update(
      'distributor_data',
      updatedValues,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
