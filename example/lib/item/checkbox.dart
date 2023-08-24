import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class ItemCheckbox extends StatefulWidget {
  const ItemCheckbox({super.key});

  @override
  State<ItemCheckbox> createState() => _ItemCheckboxState();
}

class _ItemCheckboxState extends State<ItemCheckbox> {
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

  List<String> selectedValue = [];

  void setSelectedValue(List<String> value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: InlineChoice<String>(
        value: selectedValue,
        onChanged: setSelectedValue,
        itemCount: choices.length,
        itemBuilder: (state, i) {
          return CheckboxListTile(
            value: state.selected(choices[i]),
            onChanged: state.onSelected(choices[i]),
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
