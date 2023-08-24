import 'package:flutter/material.dart';
import 'package:choice_example/sample.dart';
import 'package:choice_example/layout.dart';
import 'wrapped.dart';
import 'scrollable_x.dart';
import 'scrollable_y.dart';
import 'grid.dart';

class InlineChoicePage extends StatelessWidget {
  const InlineChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Inline Choice',
      children: <Widget>[
        SamplePanel(
          title: 'Wrapped List',
          source: 'inline/wrapped.dart',
          child: InlineWrapped(),
        ),
        SamplePanel(
          title: 'Scrollable Horizontal',
          source: 'inline/scrollable_x.dart',
          child: InlineScrollableX(),
        ),
        SamplePanel(
          title: 'Scrollable Vertical',
          source: 'inline/scrollable_y.dart',
          child: InlineScrollableY(),
        ),
        SamplePanel(
          title: 'Grid View',
          source: 'inline/grid.dart',
          child: InlineGrid(),
        ),
      ],
    );
  }
}
