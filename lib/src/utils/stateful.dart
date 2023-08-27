import 'package:flutter/widgets.dart';

class SafeStatefulBuilder extends StatefulWidget {
  const SafeStatefulBuilder({
    super.key,
    required this.builder,
    this.onDispose,
  });

  final StatefulWidgetBuilder builder;
  final VoidCallback? onDispose;

  @override
  SafeStatefulBuilderState createState() => SafeStatefulBuilderState();
}

class SafeStatefulBuilderState extends State<SafeStatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose?.call();
  }
}
