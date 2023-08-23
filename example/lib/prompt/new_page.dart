import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class PromptedNewPage extends StatefulWidget {
  const PromptedNewPage({super.key});

  @override
  State<PromptedNewPage> createState() => _PromptedNewPageState();
}

class _PromptedNewPageState extends State<PromptedNewPage> {
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
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Choice<String>.prompt(
          title: 'Categories',
          multiple: true,
          confirmation: true,
          value: multipleSelected,
          onChanged: setMultipleSelected,
          itemCount: choices.length,
          itemSkip: (q, i) => !ChoiceFilter.test(choices[i], q),
          itemBuilder: (state, i) {
            return CheckboxListTile(
              value: state.selected(choices[i]),
              onChanged: state.onSelected(choices[i]),
              title: ChoiceText(
                choices[i],
                highlight: state.filter?.value,
              ),
            );
          },
          modalHeaderBuilder: ChoiceModalHeader.createBuilder(),
          promptDelegate: ChoicePrompt.delegateNewPage(),
        ),
      ),
    );
  }
}
