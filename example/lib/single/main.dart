import 'package:flutter/material.dart';
import 'package:choice_example/layout.dart';
import 'package:choice_example/sample.dart';
import 'inline.dart';
import 'prompt.dart';

class SingleChoicePage extends StatelessWidget {
  const SingleChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Single Choice',
      children: <Widget>[
        SamplePanel(
          title: 'Inline Single Choice',
          child: SingleInline(),
        ),
        SamplePanel(
          title: 'Prompted Single Choice',
          child: SinglePrompted(),
        ),
      ],
    );
  }
}
