import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class DataString extends StatefulWidget {
  const DataString({super.key});

  @override
  State<DataString> createState() => _DataStringState();
}

class _DataStringState extends State<DataString> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];
  String? singleSelected;

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<String>.single(
      clearable: true,
      value: singleSelected,
      onChanged: setSingleSelected,
      itemCount: choices.length,
      itemBuilder: (selection, i) {
        return ChoiceChip(
          selected: selection.selected(choices[i]),
          onSelected: selection.onSelected(choices[i]),
          label: Text(choices[i]),
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
