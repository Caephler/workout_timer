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

  result += twoDigitSeconds;

  return result;
}

/// Special formatting for duration
/// Up to 90s - display as seconds
/// After 90s, display as minutes
String formatWorkoutDuration(Duration duration) {
  int seconds = duration.inSeconds;
  if (seconds <= 90) {
    return '${seconds}s';
  }

  int leftSeconds = seconds.remainder(60);
  int minutes = duration.inMinutes;

  return '${minutes}m ${leftSeconds}s';
}
