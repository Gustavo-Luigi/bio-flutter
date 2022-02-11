import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bio_flutter/models/measurement.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class Charts extends StatelessWidget {
  const Charts({
    Key? key,
    required List<Measurement> measurements,
  })  : _measurements = measurements,
        super(key: key);

  final List<Measurement> _measurements;

  List<Measurement> generateMuscleChartData(List<Measurement> measurements) {
    List<Measurement> cleanMuscleData = [];

    for (var measurement in measurements) {
      if (measurement.muscle != null) {
        cleanMuscleData.add(measurement);
      }
    }

    return cleanMuscleData;
  }

  List<Measurement> generateFatChartData(List<Measurement> measurements) {
    List<Measurement> cleanFatData = [];

    for (var measurement in measurements) {
      if (measurement.fat != null) {
        cleanFatData.add(measurement);
      }
    }

    return cleanFatData;
  }

  List<Measurement> generateVisceralChartData(List<Measurement> measurements) {
    List<Measurement> cleanVisceralData = [];

    for (var measurement in measurements) {
      if (measurement.visceral != null) {
        cleanVisceralData.add(measurement);
      }
    }

    return cleanVisceralData;
  }

  @override
  Widget build(BuildContext context) {
    List<Measurement> _muscleData = generateMuscleChartData(_measurements);
    List<Measurement> _fatData = generateFatChartData(_measurements);
    List<Measurement> _visceralData = generateVisceralChartData(_measurements);

    return Column(
      children: [
        SfCartesianChart(
          enableAxisAnimation: true,
          title: ChartTitle(text: 'Peso'),
          primaryXAxis: DateTimeAxis(
            dateFormat: DateFormat('dd/MM/yyyy'),
          ),
          series: [
            LineSeries(
                dataSource: _measurements,
                xValueMapper: (Measurement measurement, _) =>
                    measurement.measuredAt,
                yValueMapper: (Measurement measurement, _) =>
                    measurement.weight)
          ],
        ),
        if (_muscleData.length > 1)
          SfCartesianChart(
            enableAxisAnimation: true,
            title: ChartTitle(text: 'Músculo'),
            primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat('dd/MM/yyyy'),
            ),
            series: [
              LineSeries(
                  dataSource: _muscleData,
                  xValueMapper: (Measurement measurement, _) =>
                      measurement.measuredAt,
                  yValueMapper: (Measurement measurement, _) =>
                      measurement.muscle)
            ],
          ),
        if (_fatData.length > 1)
          SfCartesianChart(
            enableAxisAnimation: true,
            title: ChartTitle(text: 'Gordura corporal'),
            primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat('dd/MM/yyyy'),
            ),
            series: [
              LineSeries(
                  dataSource: _fatData,
                  xValueMapper: (Measurement measurement, _) =>
                      measurement.measuredAt,
                  yValueMapper: (Measurement measurement, _) => measurement.fat)
            ],
          ),
        if (_visceralData.length > 1)
          SfCartesianChart(
            enableAxisAnimation: true,
            title: ChartTitle(text: 'Gordura visceral'),
            primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat('dd/MM/yyyy'),
            ),
            series: [
              LineSeries(
                  dataSource: _visceralData,
                  xValueMapper: (Measurement measurement, _) =>
                      measurement.measuredAt,
                  yValueMapper: (Measurement measurement, _) =>
                      measurement.visceral)
            ],
          ),
      ],
    );
  }
}
