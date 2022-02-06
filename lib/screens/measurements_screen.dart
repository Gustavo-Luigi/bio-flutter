import 'package:bio_flutter/widgets/measurement_list.dart';
import 'package:flutter/material.dart';

class MeasureMentScreen extends StatelessWidget {
  const MeasureMentScreen({Key? key}) : super(key: key);

  static const routeName = 'measurements-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Medições'),
        ),
        body: const SingleChildScrollView(child: MeasurementList()));
  }
}
