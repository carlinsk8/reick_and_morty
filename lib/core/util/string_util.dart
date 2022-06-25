extension StringExtension on String {
  String enumName() {
    List<String> paths = split(".");
    return paths[paths.length - 1];
  }

  String formatPhoneNumber() {
    if (isNullOrEmpty) return this;

    if (length > 2 && length <= 7) {
      return '${substring(0, 3)}-${substring(3)}';
    } else if (length > 7 && length <= 10) {
      return '${substring(0, 3)}-${substring(3, 6)}-${substring(6)}';
    } else {
      return this;
    }
  }

  String get capitalize {
    if (this == null) {
      throw ArgumentError("string: $this");
    }

    if (isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + substring(1);
  }

  bool get isNullOrEmpty => this == null || isEmpty;

  bool get isNotNullOrNotEmpty => !isNullOrEmpty;

  DateTime toDate() => DateTime.parse(this);
}
