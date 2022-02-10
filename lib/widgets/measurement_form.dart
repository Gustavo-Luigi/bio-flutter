import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'package:bio_flutter/models/measurement.dart';
import 'package:bio_flutter/providers/screen_provider.dart';
import 'package:bio_flutter/providers/measurement_provider.dart';

class MeasurementForm extends StatefulWidget {
  const MeasurementForm({Key? key}) : super(key: key);

  @override
  State<MeasurementForm> createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<MeasurementForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _fatController = TextEditingController();
  final _waterController = TextEditingController();
  final _muscleController = TextEditingController();
  final _boneController = TextEditingController();
  final _visceralController = TextEditingController();
  final _basalController = TextEditingController();
  final _bmiController = TextEditingController();
  final _measuredAtDateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final _measuredAtTimeController = TextEditingController(text: '00:00');

  Measurement? _selectedMeasurement;
  late MeasurementProvider _measurementProvider;
  late final ScreenProvider _screenProvider;

  DateTime _measuredAtDate = DateTime.now();
  TimeOfDay _measuredAtTime = TimeOfDay.now();

  final String _requiredFieldMessage = 'Este campo é obrigatório';
  final String _mustBeANumberMessage = 'Este campo precisa ser um número';

  @override
  void didChangeDependencies() {
    _measurementProvider =
        Provider.of<MeasurementProvider>(context, listen: false);
    _selectedMeasurement = _measurementProvider.selectedMeasurement;

    _screenProvider = Provider.of<ScreenProvider>(context, listen: false);

    if (_selectedMeasurement != null) {
      _weightController.text = _selectedMeasurement!.weight.toString();
      _fatController.text = _selectedMeasurement!.fat?.toString() ?? '';
      _waterController.text = _selectedMeasurement!.water?.toString() ?? '';
      _muscleController.text = _selectedMeasurement!.muscle?.toString() ?? '';
      _boneController.text = _selectedMeasurement!.bone?.toString() ?? '';
      _visceralController.text =
          _selectedMeasurement!.visceral?.toString() ?? '';
      _basalController.text =
          _selectedMeasurement!.basal?.toStringAsFixed(0) ?? '';
      _bmiController.text = _selectedMeasurement!.bmi?.toString() ?? '';

      _measuredAtDateController.text =
          DateFormat('dd/MM/yyyy').format(_selectedMeasurement!.measuredAt);
      _measuredAtDate = _selectedMeasurement!.measuredAt;

      var _selectedTimeOfDay = TimeOfDay(
          hour: _selectedMeasurement!.measuredAt.hour,
          minute: _selectedMeasurement!.measuredAt.minute);

      _measuredAtTimeController.text =
          _selectedTimeOfDay.format(context).toString();
      _measuredAtTime = _selectedTimeOfDay;
    } else {
      _measuredAtTimeController.text = TimeOfDay.now().format(context);
    }

    super.didChangeDependencies();
  }

  void pickDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: _measuredAtDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    String formatedDate;

    if (selectedDate != null) {
      formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
      _measuredAtDate = selectedDate;

      _measuredAtDateController.text = formatedDate;
    }
  }

  void pickTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      initialTime: _measuredAtTime,
      context: context,
    );

    if (selectedTime != null) {
      _measuredAtTime = selectedTime;
      _measuredAtTimeController.text = selectedTime.format(context);
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

    DateTime measuredAt = DateTime(
      _measuredAtDate.year,
      _measuredAtDate.month,
      _measuredAtDate.day,
      _measuredAtTime.hour,
      _measuredAtTime.minute,
    );

    Measurement measurement = Measurement(
        weight: double.parse(_weightController.text),
        fat: double.tryParse(_fatController.text),
        water: double.tryParse(_waterController.text),
        muscle: double.tryParse(_muscleController.text),
        bone: double.tryParse(_boneController.text),
        visceral: double.tryParse(_visceralController.text),
        basal: double.tryParse(_basalController.text),
        bmi: double.tryParse(_bmiController.text),
        measuredAt: measuredAt);

    if (_selectedMeasurement == null) {
      _measurementProvider.saveMeasurement(measurement);
    } else {
      measurement.id = _selectedMeasurement!.id;
      _measurementProvider.updateMeasurement(measurement);
    }

    _screenProvider.selectedScreen = Screen.home;
  }

  void handleDelete() {
    _measurementProvider.deleteMeasurement(_selectedMeasurement!);
    _screenProvider.selectedScreen = Screen.home;
  }

  @override
  void dispose() {
    _measurementProvider.selectedMeasurement = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            controller: _weightController,
            decoration: const InputDecoration(label: Text('Peso* (kg)')),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (_isNullOrEmpty(value)) {
                return _requiredFieldMessage;
              }
              if (_isStringANumber(value!)) {
                return null;
              }
              return _mustBeANumberMessage;
            },
          ),
          TextFormField(
            controller: _fatController,
            decoration: const InputDecoration(label: Text('Gordura (%)')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: _waterController,
            decoration: const InputDecoration(label: Text('Água (%)')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: _muscleController,
            decoration: const InputDecoration(label: Text('Músculo (kg)')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: _boneController,
            decoration: const InputDecoration(label: Text('Ossos (kg)')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: _visceralController,
            decoration: const InputDecoration(label: Text('Visceral (%)')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: _basalController,
            decoration: const InputDecoration(label: Text('Basal')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: _bmiController,
            decoration: const InputDecoration(label: Text('IMC')),
            keyboardType: TextInputType.number,
            validator: _validateOptionalNumberField,
          ),
          TextFormField(
            controller: _measuredAtDateController,
            decoration: const InputDecoration(
              label: Text('Data da medição'),
              suffixIcon: Icon(
                Icons.calendar_today,
                color: Colors.blueAccent,
              ),
            ),
            keyboardType: TextInputType.number,
            readOnly: true,
            onTap: pickDate,
          ),
          TextFormField(
            controller: _measuredAtTimeController,
            decoration: const InputDecoration(
              label: Text('Hora da medição'),
              suffixIcon: Icon(
                Icons.watch_later_outlined,
                color: Colors.blueAccent,
              ),
            ),
            keyboardType: TextInputType.number,
            readOnly: true,
            onTap: pickTime,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: handleSubmit, child: const Text('Salvar')),
              if (_selectedMeasurement != null)
                ElevatedButton(
                    onPressed: handleDelete,
                    child: const Text('Excluir'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red))),
            ],
          ),
        ],
      ),
    );
  }
}
