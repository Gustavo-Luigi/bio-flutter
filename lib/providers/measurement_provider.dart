import 'package:bio_flutter/database/measurement_table.dart';
import 'package:flutter/material.dart';

import 'package:bio_flutter/models/measurement.dart';
import 'package:bio_flutter/database/database_provider.dart';

class MeasurementProvider with ChangeNotifier {
  Measurement? selectedMeasurement;
  List<Measurement> _measurementList = [];
  bool _isLoadingMeasurements = true;


  get isLoadingMeasurements {
    return _isLoadingMeasurements;
  }

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

  void clearMeasurementList() {
    _measurementList = [];
  }

  Future<bool> saveMeasurement(Measurement measurement) async {
    var connection = await DatabaseProvider.db.database;

    int measurementId = await connection.insert(
        MeasurementTable.tableName, measurement.toMap());

    if (measurementId != 0) {
      measurement.id = measurementId;
      _addMeasurementToList(measurement);
      return true;
    }

    return false;
  }

  Future<void> selectAllMeasurements() async {
    _isLoadingMeasurements = true;

    var connection = await DatabaseProvider.db.database;
    var results = await connection.query(MeasurementTable.tableName,
        orderBy: MeasurementTable.measuredAt);

    List<Measurement> selectedMeasurements = [];

    for (var measurement in results) {
      Measurement newMeasurement = Measurement.fromMap(measurement);
      selectedMeasurements.add(newMeasurement);
    }

    measurementList = selectedMeasurements;
    _isLoadingMeasurements = false;
  }

  Future<void> selectPaginatedMeasurements({
    int? quantity,
    required int month,
    required int year,
  }) async {
    _isLoadingMeasurements = true;
    var connection = await DatabaseProvider.db.database;
    var results = await connection.query(MeasurementTable.tableName,
        where:
            '(${MeasurementTable.measuredAtMonth} = ? AND ${MeasurementTable.measuredAtYear} = ?)',
        whereArgs: [month, year],
        orderBy: '${MeasurementTable.measuredAt} DESC',
        limit: quantity);

    List<Measurement> selectedMeasurements = [];

    for (var measurement in results) {
      Measurement newMeasurement = Measurement.fromMap(measurement);
      selectedMeasurements.add(newMeasurement);
    }

    measurementList = selectedMeasurements;
    _isLoadingMeasurements = false;
  }

  Future<void> updateMeasurement(Measurement measurement) async {
    var connection = await DatabaseProvider.db.database;

    await connection.update(
      MeasurementTable.tableName,
      measurement.toMap(),
      where: '${MeasurementTable.id} = ?',
      whereArgs: [measurement.id],
    );
  }

  Future<void> deleteMeasurement(Measurement measurement) async {
    var connection = await DatabaseProvider.db.database;

    await connection.delete(
      MeasurementTable.tableName,
      where: '${MeasurementTable.id} = ?',
      whereArgs: [measurement.id],
    );
  }
}
