import 'package:flutter/material.dart';

import 'package:bio_flutter/models/measurement.dart';

class MeasurementList extends StatefulWidget {
  const MeasurementList({Key? key}) : super(key: key);

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

  for(final measurement in measurementList) {
    Item item = Item(
        measurement: measurement,
        headerValue: measurement.measuredAt.toString());
    itemList.add(item);
  }

  return itemList;
}

class _MeasurementListState extends State<MeasurementList> {
  static List<Measurement> measurements = [
    Measurement(weight: 93, fat: 26, measuredAt: DateTime.now()),
    Measurement(weight: 93, measuredAt: DateTime(2022, 1, 15)),
    Measurement(weight: 93, measuredAt: DateTime(2022, 1, 5)),
  ];

  final List<Item> _data = generateItems(measurements);

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
                spacing: 20,
                children: [
                  Text('Peso: ${item.measurement.weight}'),

                  item.measurement.fat != null 
                  ?
                    Text('Gordura: ${item.measurement.fat}%')
                  : const Text('Gordura: --'),

                  item.measurement.water != null 
                  ?
                    Text('Gordura: ${item.measurement.water}%')
                  : const Text('Água: --'),

                  item.measurement.muscle != null 
                  ?
                    Text('Mpusculo: ${item.measurement.muscle}kg')
                  : const Text('Músculo: --'),

                  item.measurement.muscle != null 
                  ?
                    Text('Ossos: ${item.measurement.bone}kg')
                  : const Text('Ossos: --'),

                  item.measurement.muscle != null 
                  ?
                    Text('Visceral: ${item.measurement.visceral}%')
                  : const Text('Visceral: --'),

                  item.measurement.basal != null 
                  ?
                    Text('Basal: ${item.measurement.basal}%')
                  : const Text('Basal: --'),

                  item.measurement.bmi != null 
                  ?
                    Text('IMC: ${item.measurement.bmi}')
                  : const Text('IMC: --'),
                ],
              ),
              // subtitle:
              //     const Text('To delete this panel, tap the trash can icon'),
              // trailing: const Icon(Icons.delete),
              // onTap: () {
              //   setState(() {
              //     _data.removeWhere((Item currentItem) => item == currentItem);
              //   });
              // }
              ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
