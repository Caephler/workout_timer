part of 'timer_bloc.dart';

@immutable
abstract class TimerState {
  final Duration duration;

  const TimerState(this.duration);
}

class TimerInitial extends TimerState {
  const TimerInitial(Duration duration) : super(duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerRunPause extends TimerState {
  const TimerRunPause(Duration duration) : super(duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(Duration duration) : super(duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(const Duration());
}
