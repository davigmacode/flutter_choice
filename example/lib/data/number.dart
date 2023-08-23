import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class DataNumber extends StatefulWidget {
  const DataNumber({super.key});

  @override
  State<DataNumber> createState() => _DataNumberState();
}

class _DataNumberState extends State<DataNumber> {
  List<int> choices = Iterable<int>.generate(10).toList();
  int? singleSelected;

  void setSingleSelected(int? value) {
    setState(() => singleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<int>.single(
      clearable: true,
      value: singleSelected,
      onChanged: setSingleSelected,
      itemCount: choices.length,
      itemBuilder: (selection, i) {
        return ChoiceChip(
          selected: selection.selected(choices[i]),
          onSelected: selection.onSelected(choices[i]),
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
