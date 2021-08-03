import 'package:workout_timer/common/workouts.dart';

class WorkoutBlocks {
  WorkoutBlocks._();

  static WorkoutBlocks instance = WorkoutBlocks._();

  WorkoutBlock _make(String name, int seconds) {
    return WorkoutBlock(
      name: name,
      type: WorkoutType.Time,
      duration: Duration(seconds: seconds),
    );
  }

  WorkoutBlock jumpingJacks(int seconds) {
    return _make('Jumping Jacks', seconds);
  }

  WorkoutBlock crunches(int seconds) {
    return _make('Crunches', seconds);
  }

  WorkoutBlock russianTwists(int seconds) {
    return _make('Russian Twists', seconds);
  }

  WorkoutBlock heelTouches(int seconds) {
    return _make('Heel Touches', seconds);
  }

  WorkoutBlock flutterKicks(int seconds) {
    return _make('Flutter Kicks', seconds);
  }

  WorkoutBlock sidePlankL(int seconds) {
    return _make('Side Plank (L)', seconds);
  }

  WorkoutBlock sidePlankR(int seconds) {
    return _make('Side Plank (R)', seconds);
  }

  WorkoutBlock plank(int seconds) {
    return _make('Plank', seconds);
  }

  WorkoutBlock rest(int seconds) {
    return _make('Rest', seconds);
  }

  WorkoutBlock highIntensity(int seconds) {
    return _make('High Intensity Workout', seconds);
  }

  WorkoutBlock coolDown(int seconds) {
    return _make('Cool Down', seconds);
  }
}

final _wb = WorkoutBlocks.instance;

final List<Workout> presetWorkouts = [
  Workout(
    name: '7minute Abs',
    sequences: [
      WorkoutSequence.only(_wb.jumpingJacks(15)),
      WorkoutSequence.only(_wb.crunches(45)),
      WorkoutSequence.only(_wb.rest(15)),
      WorkoutSequence.only(_wb.russianTwists(45)),
      WorkoutSequence.only(_wb.rest(15)),
      WorkoutSequence.only(_wb.heelTouches(45)),
      WorkoutSequence.only(_wb.rest(15)),
      WorkoutSequence.only(_wb.flutterKicks(45)),
      WorkoutSequence.only(_wb.rest(15)),
      WorkoutSequence.only(_wb.sidePlankL(45)),
      WorkoutSequence.only(_wb.rest(15)),
      WorkoutSequence.only(_wb.sidePlankR(45)),
      WorkoutSequence.only(_wb.rest(15)),
      WorkoutSequence.only(_wb.plank(45)),
    ],
  ),
  Workout(name: '15-minute HIIT', sequences: [
    WorkoutSequence.only(_wb.jumpingJacks(30)),
    WorkoutSequence(blocks: [
      _wb.highIntensity(50),
      _wb.rest(10),
    ], repeatTimes: 14),
    WorkoutSequence.only(_wb.coolDown(30)),
  ])
];
