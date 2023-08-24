import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class FormInline extends StatefulWidget {
  const FormInline({super.key});

  @override
  State<FormInline> createState() => _FormInlineState();
}

class _FormInlineState extends State<FormInline> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final formKey = GlobalKey<FormState>();

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

  void setSelectedValue(List<String>? value) {
    setState(() => selectedValue = value ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormField<List<String>>(
            autovalidateMode: AutovalidateMode.always,
            initialValue: selectedValue,
            onSaved: setSelectedValue,
            validator: (value) {
              if (value?.isEmpty ?? value == null) {
                return 'Please select some categories';
              }
              if (value!.length > 5) {
                return "Can't select more than 5 categories";
              }
              return null;
            },
            builder: (formState) {
              return Column(
                children: [
                  InlineChoice<String>(
                    multiple: true,
                    clearable: true,
                    value: formState.value ?? [],
                    onChanged: (val) => formState.didChange(val),
                    itemCount: choices.length,
                    itemBuilder: (selection, i) {
                      return ChoiceChip(
                        selected: selection.selected(choices[i]),
                        onSelected: selection.onSelected(choices[i]),
                        label: Text(choices[i]),
                      );
                    },
                    listBuilder: ChoiceList.createWrapped(
                      spacing: 10,
                      runSpacing: 10,
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      formState.errorText ??
                          '${formState.value!.length}/5 selected',
                      style: TextStyle(
                        color: formState.hasError
                            ? Colors.redAccent
                            : Colors.green,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Submitted Value:'),
                      const SizedBox(height: 5),
                      Text(selectedValue.toString())
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (formKey.currentState!.validate()) {
                      // If the form is valid, save the value.
                      formKey.currentState!.save();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
