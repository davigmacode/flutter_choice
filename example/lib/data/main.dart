import 'package:flutter/material.dart';
import 'package:choice_example/layout.dart';
import 'package:choice_example/sample.dart';
import 'string.dart';
import 'number.dart';
import 'object.dart';

class DataChoicePage extends StatelessWidget {
  const DataChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Choice Data',
      children: <Widget>[
        SamplePanel(
          title: 'String as Choice Value',
          child: DataString(),
        ),
        SamplePanel(
          title: 'Number as Choice Value',
          child: DataNumber(),
        ),
        SamplePanel(
          title: 'Object as Choice Value',
          child: DataObject(),
        ),
      ],
    );
  }
}
