import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class ItemRadio extends StatefulWidget {
  const ItemRadio({super.key});

  @override
  State<ItemRadio> createState() => _ItemRadioState();
}

class _ItemRadioState extends State<ItemRadio> {
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
      height: 200,
      child: InlineChoice<String>(
        value: multipleSelected,
        onChanged: setMultipleSelected,
        itemCount: choices.length,
        itemBuilder: (state, i) {
          return RadioListTile(
            value: choices[i],
            groupValue: state.single,
            onChanged: (value) {
              state.select(choices[i]);
            },
            title: Text(choices[i]),
          );
        },
        listBuilder: ChoiceList.createVirtualized(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}
