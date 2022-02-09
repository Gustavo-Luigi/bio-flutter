import 'package:bio_flutter/widgets/measurement_list.dart';
import 'package:flutter/material.dart';

class MeasurementsScreen extends StatelessWidget {
  const MeasurementsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: MeasurementList(),
    );
  }
}