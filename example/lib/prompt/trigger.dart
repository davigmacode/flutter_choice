import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class PromptedTrigger extends StatefulWidget {
  const PromptedTrigger({super.key});

  @override
  State<PromptedTrigger> createState() => _PromptedTriggerState();
}

class _PromptedTriggerState extends State<PromptedTrigger> {
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

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          SizedBox(
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
                      highlight: state.search?.value,
                    ),
                  );
                },
                triggerBuilder: ChoiceTrigger.createBuilder(inline: true),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: PromptedChoice<String>.multiple(
                title: 'Category',
                clearable: true,
                value: multipleSelected,
                onChanged: setMultipleSelected,
                itemCount: choices.length,
                itemBuilder: (state, i) {
                  return CheckboxListTile(
                    value: state.selected(choices[i]),
                    onChanged: state.onSelected(choices[i]),
                    title: ChoiceText(
                      choices[i],
                      highlight: state.search?.value,
                    ),
                  );
                },
                triggerBuilder: ChoiceTrigger.createBuilder(valueTruncate: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
