enum DateFilter {
  yesterday,
  today,
  tomorrow,
}

extension DateFilterExtension on DateFilter {
  String get label {
    switch (this) {
      case DateFilter.yesterday:
        return 'Yesterday';
      case DateFilter.today:
        return 'Today';
      case DateFilter.tomorrow:
        return 'Tomorrow';
    }
  }
}