import 'package:bio_flutter/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bio_flutter/providers/measurement_provider.dart';
import 'package:provider/provider.dart';

class MeasurementForm extends StatefulWidget {
  const MeasurementForm({
    Key? key,
  }) : super(key: key);

  @override
  State<MeasurementForm> createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<MeasurementForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController fatPercentageController = TextEditingController();
  TextEditingController waterController = TextEditingController();
  TextEditingController muscleController = TextEditingController();
  TextEditingController boneController = TextEditingController();
  TextEditingController visceralFatController = TextEditingController();
  TextEditingController basalController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController measuredAtDateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController measuredAtTimeController =
      TextEditingController(text: '00:00');

  DateTime measuredAtDate = DateTime.now();
  TimeOfDay measuredAtTime = TimeOfDay.now();

  String requiredFieldMessage = 'Este campo é obrigatório';
  String mustBeANumberMessage = 'Este campo precisa ser um número';

  void pickDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: measuredAtDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    String formatedDate;

    if (selectedDate != null) {
      formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
      measuredAtDate = selectedDate;

      measuredAtDateController.text = formatedDate;
    }
  }

  void pickTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      initialTime: measuredAtTime,
      context: context,
    );

    if (selectedTime != null) {
      measuredAtTime = selectedTime;
      measuredAtTimeController.text = selectedTime.format(context);
    }
  }

  String? _validateOptionalNumberField(String? value) {
    if (_isNullOrEmpty(value)) {
      return null;
    }

    if (_isStringANumber(value!)) {
      return null;
    }

    return 'Preencha este campo com um número';
  }

  bool _isNullOrEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return false;
  }

  bool _isStringANumber(String value) {
    double? isNumber = double.tryParse(value);

    if (isNumber == null) {
      return false;
    }

    return true;
  }

  void handleSubmit() async {
    _key.currentState!.validate();

    final measurementProvider =
        Provider.of<MeasurementProvider>(context, listen: false);

    Measurement measurement = Measurement(
        weight: double.parse(weightController.text),
        measuredAt: measuredAtDate);

    measurementProvider.saveMeasurement(measurement);
  }

  @override
  Widget build(BuildContext context) {
    measuredAtTimeController.text = TimeOfDay.now().format(context);
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            controller: weightController,
            decoration: const InputDecoration(label: Text('Peso* (kg)')),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (_isNullOrEmpty(value)) {
                return requiredFieldMessage;
              }
              if (_isStringANumber(value!)) {
                return null;
              }
              return mustBeANumberMessage;
            },
          ),
          TextFormField(
            controller: fatPercentageController,
            decoration: const InputDecoration(label: Text('Gordura (%)')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: waterController,
            decoration: const InputDecoration(label: Text('Água (%)')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: muscleController,
            decoration: const InputDecoration(label: Text('Músculo (kg)')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: boneController,
            decoration: const InputDecoration(label: Text('Ossos (kg)')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: visceralFatController,
            decoration: const InputDecoration(label: Text('Visceral (%)')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: basalController,
            decoration: const InputDecoration(label: Text('Basal')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: bmiController,
            decoration: const InputDecoration(label: Text('IMC')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: measuredAtDateController,
            decoration: const InputDecoration(
                label: Text('Data da medição'),
                suffixIcon: Icon(Icons.calendar_today)),
            keyboardType: TextInputType.number,
            readOnly: true,
            onTap: pickDate,
          ),
          TextFormField(
            controller: measuredAtTimeController,
            decoration: const InputDecoration(
                label: Text('Hora da medição'),
                suffixIcon: Icon(Icons.watch_later_outlined)),
            keyboardType: TextInputType.number,
            readOnly: true,
            onTap: pickTime,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: handleSubmit, child: const Text('Salvar')),
        ],
      ),
    );
  }
}
