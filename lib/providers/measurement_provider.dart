import 'package:bio_flutter/database/measurement_table.dart';
import 'package:flutter/material.dart';

import 'package:bio_flutter/models/measurement.dart';
import 'package:bio_flutter/database/database_provider.dart';

class MeasurementProvider with ChangeNotifier {
  Measurement? selectedMeasurement;
  List<Measurement> _measurementList = [];

  List<Measurement> get measurementList {
    return [..._measurementList];
  }

  set measurementList(List<Measurement> measurements) {
    _measurementList = [...measurements];
    notifyListeners();
  }

  void _addMeasurementToList(Measurement measurement) {
    _measurementList.add(measurement);
    notifyListeners();
  }

  Future<bool> saveMeasurement(Measurement measurement) async {
    int measurementId = await _saveMeasurementToDatabase(measurement);

    if (measurementId != 0) {
      measurement.id = measurementId;
      _addMeasurementToList(measurement);
      return true;
    }

    return false;
  }

  void selectMeasurementById() {
    // handle select from db
  }

  Future<void> selectAllMeasurements() async {
    var connection = await DatabaseProvider.db.database;
    var results = await connection.query(MeasurementTable.tableName);

    List<Measurement> selectedMeasurements = [];

    for (var measurement in results) {
      Measurement newMeasurement = Measurement.fromMap(measurement);
      selectedMeasurements.add(newMeasurement);
    }

    measurementList = selectedMeasurements;
  }

  void updateMeasurement(Measurement measurement) async {
    var connection = await DatabaseProvider.db.database;

    await connection.update(
      MeasurementTable.tableName,
      measurement.toMap(),
      where: '${MeasurementTable.id} = ?',
      whereArgs: [measurement.id],
    );
  }

  void deleteMeasurement(Measurement measurement) async {
        var connection = await DatabaseProvider.db.database;

      await connection.delete(
      MeasurementTable.tableName,
      where: '${MeasurementTable.id} = ?',
      whereArgs: [measurement.id],
    );
  }

  Future<int> _saveMeasurementToDatabase(Measurement measurement) async {
    var connection = await DatabaseProvider.db.database;
    return await connection.insert(
        MeasurementTable.tableName, measurement.toMap());
  }
}
