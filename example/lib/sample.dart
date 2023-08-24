import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SamplePanel extends StatelessWidget {
  const SamplePanel({
    super.key,
    required this.title,
    required this.source,
    required this.child,
  });

  final String title;
  final String source;
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
                  onPressed: () async {
                    const prefix =
                        'https://github.com/davigmacode/flutter_choice/blob/main/example/lib/';
                    final Uri url = Uri.parse(prefix + source);
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
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
