import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class InlineWrapped extends StatefulWidget {
  const InlineWrapped({super.key});

  @override
  State<InlineWrapped> createState() => _InlineWrappedState();
}

class _InlineWrappedState extends State<InlineWrapped> {
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
  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<String>(
      multiple: true,
      clearable: true,
      value: multipleSelected,
      onChanged: setMultipleSelected,
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
