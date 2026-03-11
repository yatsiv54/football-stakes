import 'package:intl/intl.dart';

String getDateForAppbar() {
  final now = DateTime.now();
  final formatted = DateFormat('EEE, MMM d ').format(now);
  return formatted.toUpperCase();
}

String formatMatchDate(DateTime date) {
  return DateFormat('HH:mm').format(date);
}
