import 'package:flutter/material.dart';

import 'package:bio_flutter/widgets/measurement_form.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  static const routeName = 'measurement-form';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova medição')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const MeasurementForm(),
        ),
      ),
    );
  }
}
