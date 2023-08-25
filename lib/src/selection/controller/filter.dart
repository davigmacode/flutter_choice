import 'package:flutter/widgets.dart';
import 'package:choice/utils.dart';

/// {@template choice.filter}
/// Controller of the filter value and how it behaves
/// {@endtemplate}
class ChoiceFilterController extends ChangeNotifier {
  /// Create a controller of the filter value and how it behaves
  ChoiceFilterController({
    required this.onAttach,
    required this.onDetach,
    this.onChanged,
  });

  /// Called when filter attached
  ///
  /// Usually function to add history to route
  /// ```dart
  /// ChoiceFilterController(
  ///   onAttach: (state) {
  ///     // add history to route, so back button will appear
  ///     // and when physical back button pressed
  ///     // will close the search bar instead of close the modal
  ///     LocalHistoryEntry entry = LocalHistoryEntry(onRemove: state.deactivate);
  ///     ModalRoute.of(context)?.addLocalHistoryEntry(entry);
  ///   }
  /// )
  /// ```
  final ValueSetter<ChoiceFilterController> onAttach;

  /// Called when filter attached
  ///
  /// Usually function to remove history from route
  /// ```dart
  /// ChoiceFilterController(
  ///   onDetach: (state) {
  ///     // remove filter from route history
  ///     Navigator.pop(context);
  ///   }
  /// )
  /// ```
  final ValueSetter<ChoiceFilterController> onDetach;

  /// Called when filter value changed
  final ValueSetter<String>? onChanged;

  /// Debounce used in search text on changed
  final Debounce _debounce = Debounce();

  bool _active = false;

  String _value = '';

  /// Returns `true` if the filter is displayed
  bool get active => _active;

  /// Returns the current filter value
  String get value => _value;

  /// Call [activate] and [onAttach]
  void attach() {
    if (!_active) {
      onAttach(this);
      activate();
    }
  }

  /// Call [deactivate] and [onDetach]
  void detach() {
    if (_active) {
      onDetach(this);
      deactivate();
    }
  }

  /// Set filter active to `true`
  void activate() {
    _active = true;
    notifyListeners();
  }

  /// Set filter active to `false` and clear value
  void deactivate() {
    _active = false;
    clear();
  }

  /// Just clear the filter text
  void clear() {
    apply('');
  }

  /// Apply new value to filter query
  void _apply(String val) {
    _value = val;
    onChanged?.call(val);
    notifyListeners();
  }

  /// Apply new value to filter query
  void apply(String val, [Duration? delay]) {
    if (delay != null) {
      _debounce.run(
        () => _apply(val),
        delay: delay,
      );
    } else {
      _apply(val);
    }
  }
}
