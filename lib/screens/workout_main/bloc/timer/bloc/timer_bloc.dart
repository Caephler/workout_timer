import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workout_timer/common/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const Duration tickPeriod = const Duration(seconds: 1);
  final Ticker _ticker;

  StreamSubscription<Duration>? _tickerSubscription;

  TimerBloc({required Duration duration})
      : _ticker = Ticker(),
        super(TimerInitial(duration));

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState(event);
    } else if (event is TimerTicked) {
      yield* _mapTimerTickedToState(event);
    } else if (event is TimerPaused) {
      yield* _mapTimerPausedToState(event);
    } else if (event is TimerResumed) {
      yield* _mapTimerResumedToState(event);
    } else if (event is TimerReset) {
      yield* _mapTimerResetToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted startEvent) async* {
    yield TimerRunInProgress(startEvent.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(period: tickPeriod).listen(
          (duration) => add(
            TimerTicked(duration: duration),
          ),
        );
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async* {
    Duration remainingTime = state.duration - tick.duration;
    if (remainingTime > Duration()) {
      yield TimerRunInProgress(remainingTime);
    } else {
      _tickerSubscription?.cancel();
      yield TimerRunComplete();
    }
  }

  Stream<TimerState> _mapTimerPausedToState(TimerPaused paused) async* {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      yield TimerRunPause(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumed resumed) async* {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      yield TimerRunInProgress(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResetToState(TimerReset reset) async* {
    _tickerSubscription?.cancel();
    yield TimerInitial(Duration(seconds: 0));
  }
}
