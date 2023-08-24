import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class DataNumber extends StatefulWidget {
  const DataNumber({super.key});

  @override
  State<DataNumber> createState() => _DataNumberState();
}

class _DataNumberState extends State<DataNumber> {
  List<int> choices = Iterable<int>.generate(10).toList();
  int? selectedValue;

  void setSelectedValue(int? value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<int>.single(
      clearable: true,
      value: selectedValue,
      onChanged: setSelectedValue,
      itemCount: choices.length,
      itemBuilder: (state, i) {
        return ChoiceChip(
          selected: state.selected(choices[i]),
          onSelected: state.onSelected(choices[i]),
          label: Text(choices[i].toString()),
        );
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        runSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}
