String padTwoDigits(int n) => n.toString().padLeft(2, '0');

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  String result = '';
  int hours = duration.inHours;

  if (hours > 0) {
    result += '${twoDigits(hours)}"';
  }

  int minutes = duration.inMinutes;
  result += '${twoDigits(minutes.remainder(60))}\'';

  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  result += '${twoDigitSeconds}';

  return result;
}
