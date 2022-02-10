import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:bio_flutter/database/measurement_table.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await createDatabase();

    return _database!;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'measurement_db.db'),
      version: 2,
      onCreate: (Database database, int version) async {
        await database.execute(MeasurementTable.createTable());
      },
    );
  }
}
