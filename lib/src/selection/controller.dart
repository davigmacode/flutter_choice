import 'package:flutter/widgets.dart';

class ChoiceSelectionController<T> extends ChangeNotifier {
  ChoiceSelectionController({
    List<T> value = const [],
    this.onChanged,
    this.multiple = false,
    this.mandatory = false,
    this.title,
  }) : _value = Set.from(value);

  ChoiceSelectionController<T> copyWith({
    List<T>? value,
    ValueChanged<List<T>>? onChanged,
    bool? multiple,
    bool? mandatory,
  }) {
    return ChoiceSelectionController<T>(
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      multiple: multiple ?? this.multiple,
      mandatory: mandatory ?? this.mandatory,
    );
  }

  final Set<T> _value;
  final ValueChanged<List<T>>? onChanged;

  final String? title;

  /// allow to select multiple values
  final bool multiple;

  /// will always have a value
  final bool mandatory;

  List<T> get value => _value.toList();

  int get length => _value.length;

  bool get isEmpty => _value.isEmpty;

  bool get isNotEmpty => _value.isNotEmpty;

  bool selected(T choice) => _value.contains(choice);

  bool any(List<T> choices) => choices.any((e) => _value.contains(e));

  bool every(List<T> choices) => choices.every((e) => _value.contains(e));

  bool? selectedMany(List<T> choices) => every(choices)
      ? true
      : any(choices)
          ? null
          : false;

  ValueChanged<bool?> onSelectedMany(
    List<T> choices, {
    ValueChanged<List<T>>? onChanged,
  }) {
    return (bool? active) {
      selectMany(choices, active);
      onChanged?.call(value);
    };
  }

  ValueChanged<bool?> onSelected(
    T choice, {
    ValueChanged<List<T>>? onChanged,
  }) {
    return (bool? active) {
      if (selected(choice) == active) return;
      select(choice, active);
      onChanged?.call(value);
    };
  }

  /// Mutator to mark a [List<T>] value as either active or inactive.
  void selectMany(List<T> choices, [bool? active]) {
    active ??= false;
    if (active) {
      replace(choices);
    } else {
      clear();
    }
  }

  /// Mutator to mark a [T] value as either active or inactive.
  void select(T choice, [bool? active]) {
    active = active ?? !selected(choice);
    if (active) {
      if (multiple) {
        add(choice);
      } else {
        replace([choice]);
      }
    } else {
      remove(choice);
    }
  }

  /// Mutator to mark a [T] value as active.
  void add(T choice) {
    if (_value.add(choice)) {
      notifyListeners();
      onChanged?.call(value);
    }
  }

  /// Mutator to mark a [T] value as inactive.
  void remove(T choice) {
    if (mandatory && _value.length == 1) return;

    if (_value.remove(choice)) {
      notifyListeners();
      onChanged?.call(value);
    }
  }

  void replace(List<T> choices) {
    _value
      ..clear()
      ..addAll(choices);
    notifyListeners();
    onChanged?.call(value);
  }

  void clear() {
    _value.clear();
    notifyListeners();
    onChanged?.call(value);
  }
}
