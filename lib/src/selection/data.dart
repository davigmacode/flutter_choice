/// Choice data
class ChoiceData<T> {
  /// Value to return
  final T value;

  /// Represent as primary text
  final String title;

  /// Represent as secondary text
  final String? subtitle;

  /// Represent as group name
  final String? group;

  /// Image url to use with choice item.
  final String? image;

  /// Tooltip string to be used for the body area.
  final String? tooltip;

  /// Whether the choice is disabled or not
  final bool disabled;

  /// Whether the choice is hidden or displayed
  final bool hidden;

  /// Default Constructor
  const ChoiceData({
    required this.value,
    required this.title,
    this.subtitle,
    this.group,
    this.image,
    this.tooltip,
    this.disabled = false,
    this.hidden = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceData &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => Object.hash(
        value,
        title,
        subtitle,
        group,
        image,
        tooltip,
        disabled,
        hidden,
      );

  @override
  String toString() => title;

  /// Creates a copy of this [ChoiceData] but with
  /// the given fields replaced with the new values.
  ChoiceData<T> copyWith({
    T? value,
    String? title,
    String? subtitle,
    String? group,
    String? image,
    String? tooltip,
    bool? disabled,
    bool? hidden,
  }) {
    return ChoiceData<T>(
      value: value ?? this.value,
      title: title ?? this.title,
      group: group ?? this.group,
      image: image ?? this.image,
      tooltip: tooltip ?? this.tooltip,
      disabled: disabled ?? this.disabled,
      hidden: hidden ?? this.hidden,
    );
  }

  /// Creates a copy of this [ChoiceData] but with
  /// the given fields replaced with the new values.
  ChoiceData<T> merge(ChoiceData<T>? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      value: other.value,
      title: other.title,
      subtitle: other.subtitle,
      group: other.group,
      image: other.image,
      tooltip: other.tooltip,
      disabled: other.disabled,
      hidden: other.hidden,
    );
  }
}

/// Builder for option prop
typedef ChoiceDataProp<E, R> = R? Function(int index, E item);

/// Helper to create list of [ChoiceData] from any list
extension ChoiceDataGeneration<T> on List<T> {
  List<ChoiceData<R>> asChoiceData<R>({
    required R Function(int index, T item) value,
    required String Function(int index, T item) title,
    ChoiceDataProp<T, String>? subtitle,
    ChoiceDataProp<T, String>? group,
    ChoiceDataProp<T, String>? image,
    ChoiceDataProp<T, String>? tooltip,
    ChoiceDataProp<T, bool>? disabled,
    ChoiceDataProp<T, bool>? hidden,
  }) {
    return asMap()
        .map((index, item) {
          return MapEntry(
            index,
            ChoiceData<R>(
              value: value.call(index, item),
              title: title.call(index, item),
              subtitle: subtitle?.call(index, item),
              group: group?.call(index, item),
              image: image?.call(index, item),
              tooltip: tooltip?.call(index, item),
              disabled: disabled?.call(index, item) ?? false,
              hidden: hidden?.call(index, item) ?? false,
            ),
          );
        })
        .values
        .toList();
  }
}
