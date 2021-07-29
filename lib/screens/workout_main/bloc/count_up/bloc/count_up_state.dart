part of 'count_up_bloc.dart';

@immutable
abstract class CountUpState {
  final Duration duration;

  const CountUpState(this.duration);
}

class CountUpInitial extends CountUpState {
  const CountUpInitial(Duration duration) : super(duration);
}

class CountUpRunPause extends CountUpState {
  const CountUpRunPause(Duration duration) : super(duration);

  @override
  String toString() => 'CountUpRunPause { duration: $duration }';
}

class CountUpRunInProgress extends CountUpState {
  const CountUpRunInProgress(Duration duration) : super(duration);

  @override
  String toString() => 'CountUpRunInProgress { duration: $duration }';
}

class CountUpRunFinished extends CountUpState {
  const CountUpRunFinished(Duration duration) : super(duration);

  @override
  String toString() => 'CountUpRunInProgress { duration: $duration }';
}
