import 'package:bio_flutter/database/measurement_table.dart';

class Measurement {
  int? _id;
  double weight;
  double? fat;
  double? water;
  double? muscle;
  double? bone;
  double? visceral;
  double? basal;
  double? bmi;
  DateTime measuredAt;

  int? get id {
    return _id;
  }

  set id(value) {
    _id ??= value;
  }

  Measurement(
      {id,
      required this.weight,
      this.fat,
      this.water,
      this.muscle,
      this.bone,
      this.visceral,
      this.basal,
      this.bmi,
      required this.measuredAt})
      : _id = id;

  Measurement.fromMap(Map<String, dynamic> measurementMap)
      : _id = measurementMap[MeasurementTable.id],
        weight = measurementMap[MeasurementTable.weight],
        fat = measurementMap[MeasurementTable.fat],
        water = measurementMap[MeasurementTable.water],
        muscle = measurementMap[MeasurementTable.muscle],
        bone = measurementMap[MeasurementTable.bone],
        visceral = measurementMap[MeasurementTable.visceral],
        basal = measurementMap[MeasurementTable.basal],
        bmi = measurementMap[MeasurementTable.bmi],
        measuredAt =
            DateTime.parse(measurementMap[MeasurementTable.measuredAt]);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> measurementMap;

    if (_id != null) {
      measurementMap = {
        MeasurementTable.id: _id,
        MeasurementTable.weight: weight,
        MeasurementTable.fat: fat,
        MeasurementTable.water: water,
        MeasurementTable.muscle: muscle,
        MeasurementTable.bone: bone,
        MeasurementTable.visceral: visceral,
        MeasurementTable.basal: basal,
        MeasurementTable.bmi: bmi,
        MeasurementTable.measuredAt: measuredAt.toString(),
      };
    } else {
      measurementMap = {
        MeasurementTable.weight: weight,
        MeasurementTable.fat: fat,
        MeasurementTable.water: water,
        MeasurementTable.muscle: muscle,
        MeasurementTable.bone: bone,
        MeasurementTable.visceral: visceral,
        MeasurementTable.basal: basal,
        MeasurementTable.bmi: bmi,
        MeasurementTable.measuredAt: measuredAt.toString(),
      };
    }

    return measurementMap;
  }
}
