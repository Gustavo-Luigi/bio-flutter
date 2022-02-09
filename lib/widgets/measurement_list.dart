import 'package:bio_flutter/providers/measurement_provider.dart';
import 'package:bio_flutter/providers/screen_provider.dart';
import 'package:flutter/material.dart';

import 'package:bio_flutter/models/measurement.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MeasurementList extends StatefulWidget {
  const MeasurementList({
    Key? key,
  }) : super(key: key);

  @override
  _MeasurementListState createState() => _MeasurementListState();
}

class Item {
  String headerValue;
  bool isExpanded;
  Measurement measurement;

  Item(
      {required this.headerValue,
      this.isExpanded = false,
      required this.measurement});
}

List<Item> generateItems(List<Measurement> measurementList) {
  List<Item> itemList = [];

  for (final measurement in measurementList) {
    Item item = Item(
        measurement: measurement,
        headerValue:
            'Medido em: ${DateFormat('dd/MM/yyyy').format(measurement.measuredAt)} às ${DateFormat('HH:mm').format(measurement.measuredAt)}');
    // headerValue: measurement.measuredAt.toString());
    itemList.add(item);
  }

  return itemList;
}

class _MeasurementListState extends State<MeasurementList> {
  bool _measurementsLoaded = false;
  List<Measurement> _measurementList = [];
  List<Item> _data = [];
  late MeasurementProvider _measurementsProvider;

  @override
  void didChangeDependencies() {
    if (!_measurementsLoaded) {
      _measurementsProvider = Provider.of<MeasurementProvider>(context);
      _measurementsProvider.selectAllMeasurements();
      _measurementsLoaded = true;
    }
    _measurementList = _measurementsProvider.measurementList;
    _data = generateItems(_measurementList);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Wrap(
              direction: Axis.vertical,
              spacing: 20,
              children: [
                Text('Peso: ${item.measurement.weight}'),
                item.measurement.fat != null
                    ? Text('Gordura: ${item.measurement.fat}%')
                    : const Text('Gordura: --'),
                item.measurement.water != null
                    ? Text('Água: ${item.measurement.water}%')
                    : const Text('Água: --'),
                item.measurement.muscle != null
                    ? Text('Músculo: ${item.measurement.muscle}kg')
                    : const Text('Músculo: --'),
                item.measurement.muscle != null
                    ? Text('Ossos: ${item.measurement.bone}kg')
                    : const Text('Ossos: --'),
                item.measurement.muscle != null
                    ? Text('Visceral: ${item.measurement.visceral}%')
                    : const Text('Visceral: --'),
                item.measurement.basal != null
                    ? Text(
                        'Basal: ${item.measurement.basal!.toStringAsFixed(0)}')
                    : const Text('Basal: --'),
                item.measurement.bmi != null
                    ? Text('IMC: ${item.measurement.bmi}')
                    : const Text('IMC: --'),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                _measurementsProvider.selectedMeasurement = item.measurement;
                Provider.of<ScreenProvider>(context, listen: false).selectedScreen =
                    Screen.form;
              },
              child: const Icon(
                Icons.edit_outlined,
                color: Colors.blueAccent,
              ),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
