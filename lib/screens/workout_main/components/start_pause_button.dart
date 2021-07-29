import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/screens/workout_main/bloc/count_up/bloc/count_up_bloc.dart';
import 'package:workout_timer/screens/workout_main/bloc/timer/timer.dart';

class StartPauseTimerButton extends StatefulWidget {
  const StartPauseTimerButton();

  @override
  _StartPauseTimerButtonState createState() => _StartPauseTimerButtonState();
}

class _StartPauseTimerButtonState extends State<StartPauseTimerButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    context.read<TimerBloc>().stream.listen((state) {
      if (state is TimerRunPause) {
        _animation.forward();
      } else if (state is TimerRunInProgress) {
        _animation.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            TimerBloc timer = context.read<TimerBloc>();
            CountUpBloc countUp = context.read<CountUpBloc>();
            TimerState state = timer.state;
            if (state is TimerRunInProgress) {
              countUp.add(CountUpPaused());
              timer.add(TimerPaused());
              _animation.forward();
            } else if (state is TimerRunPause) {
              timer.add(
                TimerResumed(),
              );
              countUp.add(
                CountUpResumed(),
              );
              _animation.reverse();
            }
          },
          style: TextButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            backgroundColor: Colors.blue[50],
          ),
          child: AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            size: 48,
            progress: _animation,
          ),
        );
      },
    );
  }
}
