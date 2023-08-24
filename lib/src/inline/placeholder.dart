import 'package:flutter/material.dart';

/// Default widget for empty choice
class ChoiceListPlaceholder extends StatelessWidget {
  /// Default constructor
  const ChoiceListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 120.0,
          ),
          SizedBox(height: 20),
          Text(
            'Whoops, no matches',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
