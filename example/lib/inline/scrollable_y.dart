import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:choice_example/item.dart';

class InlineScrollableY extends StatefulWidget {
  const InlineScrollableY({super.key});

  @override
  State<InlineScrollableY> createState() => _InlineScrollableYState();
}

class _InlineScrollableYState extends State<InlineScrollableY> {
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
    return SizedBox(
      height: 250,
      child: Choice<String>.inline(
        clearable: true,
        value: ChoiceSingle.value(singleSelected),
        onChanged: ChoiceSingle.onChanged(setSingleSelected),
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
        listBuilder: ChoiceList.createScrollable(
          direction: Axis.vertical,
          spacing: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}
