import 'package:bio_flutter/providers/measurement_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bio_flutter/providers/filter_provider.dart';

class FilterRow extends StatefulWidget {
  const FilterRow({Key? key}) : super(key: key);

  @override
  State<FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  late FilterProvider _filterProvider;
  late MeasurementProvider _measurementProvider;
  bool _loadedFilters = false;

  @override
  void didChangeDependencies() {
    while (!_loadedFilters) {
      _measurementProvider =
          Provider.of<MeasurementProvider>(context, listen: false);
      _filterProvider = Provider.of<FilterProvider>(context);
      _loadedFilters = true;
    }
    super.didChangeDependencies();
  }

  List<int> getYearList() {
    const int initialYear = 2020;
    final int finalYear = DateTime.now().year;

    List<int> yearList = [];

    for (var year = initialYear; year <= finalYear; year++) {
      yearList.add(year);
    }

    return yearList;
  }

  List<int> getMonthList() {
    List<int> monthList = [];

    for (var month = 1; month <= 12; month++) {
      monthList.add(month);
    }

    return monthList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text('Qtd: '),
            DropdownButton(
                value: _filterProvider.listSize,
                items: <int>[5, 10, 15, 20, 25, 30]
                    .map<DropdownMenuItem<int>>((selectedListSize) {
                  return DropdownMenuItem<int>(
                      value: selectedListSize,
                      child: Text(selectedListSize.toString()));
                }).toList(),
                onChanged: (int? selectedListSize) {
                  print(selectedListSize);
                  _filterProvider.listSize = selectedListSize ?? 15;
                  _measurementProvider.selectPaginatedMeasurements(
                      quantity: _filterProvider.listSize,
                      month: _filterProvider.month,
                      year: _filterProvider.year);
                }),
          ],
        ),
        Row(
          children: [
            const Text('Mês: '),
            DropdownButton(
                value: _filterProvider.month,
                items:
                    getMonthList().map<DropdownMenuItem<int>>((selectedMonth) {
                  return DropdownMenuItem<int>(
                      value: selectedMonth,
                      child: Text(selectedMonth.toString()));
                }).toList(),
                onChanged: (int? selectedMonth) {
                  _filterProvider.month = selectedMonth ?? DateTime.now().month;
                  _measurementProvider.selectPaginatedMeasurements(
                      quantity: _filterProvider.listSize,
                      month: _filterProvider.month,
                      year: _filterProvider.year);
                }),
          ],
        ),
        Row(
          children: [
            const Text('Ano: '),
            DropdownButton(
                value: _filterProvider.year,
                items: getYearList().map<DropdownMenuItem<int>>((selectedYear) {
                  return DropdownMenuItem<int>(
                      value: selectedYear,
                      child: Text(selectedYear.toString()));
                }).toList(),
                onChanged: (int? selectedYear) {
                  _filterProvider.year = selectedYear ?? DateTime.now().year;
                  _measurementProvider.selectPaginatedMeasurements(
                      quantity: _filterProvider.listSize,
                      month: _filterProvider.month,
                      year: _filterProvider.year);
                }),
          ],
        ),
      ],
    );
  }
}
