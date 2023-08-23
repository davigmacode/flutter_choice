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
          child: InlineWrapped(),
        ),
        SamplePanel(
          title: 'Scrollable Horizontal',
          child: InlineScrollableX(),
        ),
        SamplePanel(
          title: 'Scrollable Vertical',
          child: InlineScrollableY(),
        ),
        SamplePanel(
          title: 'Grid View',
          child: InlineGrid(),
        ),
      ],
    );
  }
}
