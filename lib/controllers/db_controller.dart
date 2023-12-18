import 'package:coal_tracking_app/models/logs_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocationDatabase {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'location_database.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE locations(
          id INTEGER PRIMARY KEY,
          orderId TEXT,
          latitude REAL,
          longitude REAL,
          timestamp INTEGER
        )
      ''');
    });
  }

  Future<void> insertLocation(LocationLogs location) async {
    final db = await database;
    await db.insert(
      'locations',
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<LocationLogs>> getLocationsForOrder(String orderId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'locations',
      where: 'orderId = ?',
      whereArgs: [orderId],
    );
    return List.generate(maps.length, (i) {
      return LocationLogs.fromMap(maps[i]);
    });
  }

  Future<List<String>> getAllOrderIds() async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT DISTINCT orderId FROM locations');
    List<String> orderIds = [];
    for (var item in result) {
      orderIds.add(item['orderId'] as String);
    }
    return orderIds;
  }
}
