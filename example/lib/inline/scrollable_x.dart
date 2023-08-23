import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class InlineScrollableX extends StatefulWidget {
  const InlineScrollableX({super.key});

  @override
  State<InlineScrollableX> createState() => _InlineScrollableXState();
}

class _InlineScrollableXState extends State<InlineScrollableX> {
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
    return Choice<String>.inline(
      clearable: true,
      value: ChoiceSingle.value(singleSelected),
      onChanged: ChoiceSingle.onChanged(setSingleSelected),
      itemCount: choices.length,
      itemBuilder: (state, i) {
        return ChoiceChip(
          selected: state.selected(choices[i]),
          onSelected: state.onSelected(choices[i]),
          label: Text(choices[i]),
        );
      },
      listBuilder: ChoiceList.createScrollable(
        spacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}
