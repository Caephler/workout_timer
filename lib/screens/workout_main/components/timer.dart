import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_timer/common/format.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/common/timer/bloc/timer_bloc.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration duration = context.select((TimerBloc bloc) => bloc.state.duration);

    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds.remainder(60);
    int millisecs = duration.inMilliseconds.remainder(1000);

    String result = '';
    if (minutes > 0) {
      result += '$minutes"';
    }
    result += padTwoDigits(seconds);

    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              result,
              style: AppTextStyles.display.getStyleFor(0).copyWith(
                    fontWeight: FontWeight.w900,
                  ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
              child: Text(
                (millisecs / 100).round().toString(),
                style: AppTextStyles.display.getStyleFor(3).copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
