import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workout_timer/common/ticker.dart';

part 'count_up_event.dart';
part 'count_up_state.dart';

class CountUpBloc extends Bloc<CountUpEvent, CountUpState> {
  static const Duration tickPeriod = const Duration(seconds: 1);
  final Ticker _ticker;

  StreamSubscription<Duration>? _tickerSubscription;
  CountUpBloc({Duration? duration})
      : _ticker = Ticker(),
        super(CountUpInitial(duration ?? Duration()));

  @override
  Stream<CountUpState> mapEventToState(
    CountUpEvent event,
  ) async* {
    if (event is CountUpStarted) {
      yield* _mapCountUpStartedToState(event);
    } else if (event is CountUpTicked) {
      yield* _mapCountUpTickedToState(event);
    } else if (event is CountUpPaused) {
      yield* _mapCountUpPausedToState(event);
    } else if (event is CountUpResumed) {
      yield* _mapCountUpResumedToState(event);
    } else if (event is CountUpReset) {
      yield* _mapCountUpResetToState(event);
    } else if (event is CountUpFinished) {
      yield* _mapCountUpFinished(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<CountUpState> _mapCountUpStartedToState(
      CountUpStarted startEvent) async* {
    yield CountUpRunInProgress(startEvent.duration ?? Duration());
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(period: tickPeriod).listen(
          (duration) => add(
            CountUpTicked(duration: duration),
          ),
        );
  }

  Stream<CountUpState> _mapCountUpTickedToState(CountUpTicked tick) async* {
    Duration addedTime = state.duration + tick.duration;
    yield CountUpRunInProgress(addedTime);
  }

  Stream<CountUpState> _mapCountUpPausedToState(CountUpPaused paused) async* {
    if (state is CountUpRunInProgress) {
      _tickerSubscription?.pause();
      yield CountUpRunPause(state.duration);
    }
  }

  Stream<CountUpState> _mapCountUpResumedToState(
      CountUpResumed resumed) async* {
    if (state is CountUpRunPause) {
      _tickerSubscription?.resume();
      yield CountUpRunInProgress(state.duration);
    }
  }

  Stream<CountUpState> _mapCountUpResetToState(CountUpReset reset) async* {
    _tickerSubscription?.cancel();
    yield CountUpInitial(Duration(seconds: 0));
  }

  Stream<CountUpState> _mapCountUpFinished(CountUpFinished finished) async* {
    _tickerSubscription?.cancel();
    yield CountUpRunFinished(state.duration);
  }
}
