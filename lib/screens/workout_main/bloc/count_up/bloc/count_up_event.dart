part of 'count_up_bloc.dart';

@immutable
abstract class CountUpEvent {
  const CountUpEvent();
}

class CountUpStarted extends CountUpEvent {
  const CountUpStarted({this.duration});

  final Duration? duration;
}

class CountUpPaused extends CountUpEvent {
  const CountUpPaused();
}

class CountUpResumed extends CountUpEvent {
  const CountUpResumed();
}

class CountUpReset extends CountUpEvent {
  const CountUpReset();
}

class CountUpFinished extends CountUpEvent {
  const CountUpFinished();
}

class CountUpTicked extends CountUpEvent {
  const CountUpTicked({required this.duration});

  final Duration duration;
}
