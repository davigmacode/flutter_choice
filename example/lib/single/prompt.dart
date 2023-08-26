import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class SinglePrompted extends StatefulWidget {
  const SinglePrompted({super.key});

  @override
  State<SinglePrompted> createState() => _SinglePromptedState();
}

class _SinglePromptedState extends State<SinglePrompted> {
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
    return SizedBox(
      width: 250,
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
                highlight: state.search?.value,
              ),
            );
          },
          promptDelegate: ChoicePrompt.delegateBottomSheet(),
          triggerBuilder: ChoiceTrigger.createBuilder(inline: true),
        ),
      ),
    );
  }
}
