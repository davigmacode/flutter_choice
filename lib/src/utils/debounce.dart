import 'dart:async';
import 'dart:ui';

/// A debounce function completely halts function calls
/// until the call rate of the function falls low enough
class Debounce {
  /// debounce delay
  final Duration delay;

  /// debounce timer
  Timer? _timer;

  /// default constructor
  Debounce({this.delay = const Duration(milliseconds: 250)});

  /// run the function
  run(VoidCallback action, {Duration? delay}) {
    _timer?.cancel();
    _timer = Timer(delay ?? this.delay, action);
  }
}
