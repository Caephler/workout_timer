import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/timer/timer.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            TimerBloc timer = context.read<TimerBloc>();
            TimerState state = timer.state;
            if (state is TimerRunInProgress) {
              timer.add(TimerPaused());
              _animation.forward();
            } else if (state is TimerRunPause) {
              timer.add(
                TimerResumed(),
              );
              _animation.reverse();
            }
          },
          child: AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            progress: _animation,
          ),
        );
      },
    );
  }
}
