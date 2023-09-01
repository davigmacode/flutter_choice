import 'package:flutter/material.dart';
import 'package:choice_example/layout.dart';
import 'package:choice_example/sample.dart';
import 'inline.dart';
import 'prompt.dart';

class FutureChoicePage extends StatelessWidget {
  const FutureChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Future Choice',
      children: <Widget>[
        SamplePanel(
          title: 'Future Prompted Choice',
          source: 'future/prompt.dart',
          child: FuturePrompt(),
        ),
        SamplePanel(
          title: 'Future Inline Choice',
          source: 'future/inline.dart',
          child: FutureInline(),
        ),
      ],
    );
  }
}
