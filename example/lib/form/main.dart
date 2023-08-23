import 'package:flutter/material.dart';
import 'package:choice_example/layout.dart';
import 'package:choice_example/sample.dart';
import 'inline.dart';
import 'prompt.dart';

class FormChoicePage extends StatelessWidget {
  const FormChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Form and FormField',
      children: <Widget>[
        SamplePanel(
          title: 'Inline Choice Form',
          child: FormInline(),
        ),
        SamplePanel(
          title: 'Prompted Choice Form',
          child: FormPrompt(),
        ),
      ],
    );
  }
}
