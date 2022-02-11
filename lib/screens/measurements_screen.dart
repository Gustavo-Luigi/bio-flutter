import 'package:flutter/material.dart';

import 'package:bio_flutter/widgets/measurement_list.dart';
import 'package:bio_flutter/widgets/filter_row.dart';

class MeasurementsScreen extends StatelessWidget {
  const MeasurementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: FilterRow(),
        ),
        Expanded(child: MeasurementList()),
      ],
    );
  }
}