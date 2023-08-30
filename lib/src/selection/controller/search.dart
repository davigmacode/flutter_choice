import 'package:flutter/widgets.dart';
import 'package:choice/utils.dart';

abstract class ChoiceSearch {
  static bool match(String? value, String? query) {
    return value != null
        ? query != null
            ? normalized(value).contains(normalized(query))
            : true
        : false;
  }
}

/// {@template choice.search}
/// Controller of the search value and how it behaves
/// {@endtemplate}
class ChoiceSearchController extends ChangeNotifier {
  /// Create a controller of the search value and how it behaves
  ChoiceSearchController({
    required this.onAttach,
    required this.onDetach,
    this.onChanged,
  });

  /// Called when search attached
  ///
  /// Usually function to add history to route
  /// ```dart
  /// ChoiceSearchController(
  ///   onAttach: (state) {
  ///     // add history to route, so back button will appear
  ///     // and when physical back button pressed
  ///     // will close the search bar instead of close the modal
  ///     LocalHistoryEntry entry = LocalHistoryEntry(onRemove: state.deactivate);
  ///     ModalRoute.of(context)?.addLocalHistoryEntry(entry);
  ///   }
  /// )
  /// ```
  final ValueSetter<ChoiceSearchController> onAttach;

  /// Called when search attached
  ///
  /// Usually function to remove history from route
  /// ```dart
  /// ChoiceSearchController(
  ///   onDetach: (state) {
  ///     // remove search from route history
  ///     Navigator.pop(context);
  ///   }
  /// )
  /// ```
  final ValueSetter<ChoiceSearchController> onDetach;

  /// Called when search value changed
  final ValueSetter<String>? onChanged;

  /// Debounce used in search text on changed
  final Debounce _debounce = Debounce();

  bool _active = false;

  String _value = '';

  /// Returns `true` if the search is displayed
  bool get active => _active;

  /// Returns the current search value
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

  /// Set search active to `true`
  void activate() {
    _active = true;
    notifyListeners();
  }

  /// Set search active to `false` and clear value
  void deactivate() {
    _active = false;
    clear();
  }

  /// Just clear the search text
  void clear() {
    apply('');
  }

  /// Apply new value to search query
  void _apply(String val) {
    _value = val;
    onChanged?.call(val);
    notifyListeners();
  }

  /// Apply new value to search query
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

  /// Create a nullable search controller with build context
  static ChoiceSearchController? create({
    required BuildContext context,
    bool searchable = false,
    ValueSetter<String>? onChanged,
  }) {
    return searchable
        ? ChoiceSearchController(
            onAttach: defaultOnAttach(context),
            onDetach: defaultOnDetach(context),
            onChanged: onChanged,
          )
        : null;
  }

  static ValueChanged<ChoiceSearchController> defaultOnAttach(
    BuildContext context,
  ) {
    return (state) {
      // add history to route, so back button will appear
      // and when physical back button pressed
      // will close the search bar instead of close the modal
      LocalHistoryEntry entry = LocalHistoryEntry(
        onRemove: state.deactivate,
      );
      ModalRoute.of(context)?.addLocalHistoryEntry(entry);
    };
  }

  static ValueChanged<ChoiceSearchController> defaultOnDetach(
    BuildContext context,
  ) {
    return (state) {
      // remove search from route history
      Navigator.pop(context);
    };
  }
}
