import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class PromptedPopupDialog extends StatefulWidget {
  const PromptedPopupDialog({super.key});

  @override
  State<PromptedPopupDialog> createState() => _PromptedPopupDialogState();
}

class _PromptedPopupDialogState extends State<PromptedPopupDialog> {
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
      width: 300,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: PromptedChoice<String>.single(
          title: 'Category',
          value: singleSelected,
          onChanged: setSingleSelected,
          itemCount: choices.length,
          itemBuilder: (state, i) {
            return RadioListTile(
              value: choices[i],
              groupValue: state.single,
              onChanged: (value) {
                state.select(choices[i]);
              },
              title: ChoiceText(
                choices[i],
                highlight: state.filter?.value,
              ),
            );
          },
          promptDelegate: ChoicePrompt.delegatePopupDialog(
            maxHeightFactor: .5,
            constraints: const BoxConstraints(maxWidth: 300),
          ),
          triggerBuilder: ChoiceTrigger.createBuilder(inline: true),
        ),
      ),
    );
  }
}
