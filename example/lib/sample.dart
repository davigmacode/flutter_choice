import 'package:flutter/material.dart';

class SamplePanel extends StatelessWidget {
  const SamplePanel({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(minHeight: 50),
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Code',
                  onPressed: () {},
                  icon: const Icon(Icons.code),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(minHeight: 100),
            child: child,
          ),
        ],
      ),
    );
  }
}
