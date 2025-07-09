String formatCurrentTime(DateTime now) {
  final hour = now.hour.toString().padLeft(2, '0');
  final minute = now.minute.toString().padLeft(2, '0');
  final day = now.day.toString().padLeft(2, '0');
  final month = now.month.toString().padLeft(2, '0');
  final year = now.year;

  return "$hour:$minute - $day/$month/$year";
}
