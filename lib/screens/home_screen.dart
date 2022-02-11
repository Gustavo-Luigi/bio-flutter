import 'package:bio_flutter/widgets/loading.dart';
import 'package:bio_flutter/widgets/not_enought_measurements.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bio_flutter/models/measurement.dart';
import 'package:bio_flutter/providers/measurement_provider.dart';
import 'package:bio_flutter/widgets/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _measurementsLoaded = false;
  late MeasurementProvider _measurementProvider;
  late bool _isLoading;
  List<Measurement> _measurements = [];

  @override
  void didChangeDependencies() {
    if (!_measurementsLoaded) {
      _measurementProvider = Provider.of<MeasurementProvider>(context);
      _measurementProvider.selectAllMeasurements();
      _measurementsLoaded = true;
    }
    _isLoading = _measurementProvider.isLoadingMeasurements;
    _measurements = _measurementProvider.measurementList;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: _isLoading
            ? const Loading()
            : _measurements.length > 1
                ? SingleChildScrollView(
                    child: Charts(
                      measurements: _measurements,
                    ),
                  )
                : const NotEnoughMeasurements());
  }
}
