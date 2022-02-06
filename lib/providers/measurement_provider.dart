import 'package:bio_flutter/database/measurement_table.dart';
import 'package:flutter/material.dart';

import 'package:bio_flutter/models/measurement.dart';
import 'package:bio_flutter/database/database_provider.dart';

class MeasurementProvider with ChangeNotifier {
  List<Measurement> _measurementList = [];

  List<Measurement> get measurementList {
    return [..._measurementList];
  }

  set measurementList(List<Measurement> measurements) {
    _measurementList = [...measurements];
  }

  void addMeasurementToList(Measurement measurement) {
    _measurementList.add(measurement);
    notifyListeners();
  }

  void saveMeasurement(Measurement measurement) async {
    // handle save to db
    int measurementId = await _saveMeasurementToDatabase(measurement);

    if (measurementId != 0) {
      measurement.id = measurementId;
    }

    addMeasurementToList(measurement);
  }

  void selectMeasurementById() {
    // handle select from db
  }

  void selectAllMeasurements() {
    // handle select all to db
  }

  void updateMeasurement() {
    // handle update to db
  }

  void deleteMeasurement() {
    //handle delete
  }

  Future<int> _saveMeasurementToDatabase(Measurement measurement) async {
    var connection = await DatabaseProvider.db.database;
    return await connection.insert(
        MeasurementTable.tableName, measurement.toMap());
  }
}
