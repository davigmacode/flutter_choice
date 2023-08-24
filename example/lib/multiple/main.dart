import 'package:flutter/material.dart';
import 'package:choice_example/layout.dart';
import 'package:choice_example/sample.dart';
import 'inline.dart';
import 'prompt.dart';

class MultipleChoicePage extends StatelessWidget {
  const MultipleChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Multiple Choice',
      children: <Widget>[
        SamplePanel(
          title: 'Inline Multiple Choice',
          source: 'multiple/inline.dart',
          child: MultipleInline(),
        ),
        SamplePanel(
          title: 'Prompted Multiple Choice',
          source: 'multiple/prompt.dart',
          child: MultiplePrompted(),
        ),
      ],
    );
  }
}
