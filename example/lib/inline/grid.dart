import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:choice_example/item.dart';

class InlineGrid extends StatefulWidget {
  const InlineGrid({super.key});

  @override
  State<InlineGrid> createState() => _InlineGridState();
}

class _InlineGridState extends State<InlineGrid> {
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
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 300,
        maxHeight: 300,
      ),
      child: Choice<String>.inline(
        clearable: true,
        multiple: true,
        value: multipleSelected,
        onChanged: setMultipleSelected,
        itemCount: choices.length,
        itemBuilder: (state, i) {
          return CustomChoiceItem(
            label: choices[i],
            width: 100,
            height: 80,
            selected: state.selected(choices[i]),
            onSelect: state.onSelected(choices[i]),
          );
        },
        listBuilder: ChoiceList.createGrid(
          direction: Axis.vertical,
          spacing: 10,
          columns: 3,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}
