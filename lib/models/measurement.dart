import 'package:bio_flutter/database/measurement_table.dart';

class Measurement {
  int? id;
  double weight;
  double? fat;
  double? water;
  double? muscle;
  double? bone;
  double? visceral;
  double? basal;
  double? bmi;
  DateTime measuredAt;

  Measurement(
      {required this.weight,
      this.id,
      this.fat,
      this.water,
      this.muscle,
      this.bone,
      this.visceral,
      this.basal,
      this.bmi,
      required this.measuredAt});

  Map<String, dynamic> toMap() {

    final Map<String, dynamic> measurementMap;
    
    if (id != null) {
      measurementMap = {
        MeasurementTable.id: id,
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
