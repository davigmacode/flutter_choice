import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class PromptedAnchor extends StatefulWidget {
  const PromptedAnchor({super.key});

  @override
  State<PromptedAnchor> createState() => _PromptedAnchorState();
}

class _PromptedAnchorState extends State<PromptedAnchor> {
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
                anchorBuilder: ChoiceAnchor.create(inline: true),
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
                anchorBuilder: ChoiceAnchor.create(
                  valueTruncate: 1,
                  placeholder: 'Choose one or more',
                ),
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
                anchorBuilder: ChoiceAnchor.createUntitled(
                  valueTruncate: 2,
                  trailing: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          PromptedChoice<String>.multiple(
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
            anchorBuilder: (state, openModal) {
              return ListTileTheme(
                data: const ListTileThemeData(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  titleTextStyle: TextStyle(
                    color: Colors.blue,
                  ),
                  subtitleTextStyle: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlue,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ChoiceAnchor.create(
                    valueTruncate: 2,
                    trailing: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  )(state, openModal),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
