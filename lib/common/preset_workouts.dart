import 'package:workout_timer/common/workouts.dart';

class PresetWorkout {
  PresetWorkout(this.workout, this.description);

  final Workout workout;
  final String description;
}

class WorkoutBlocks {
  WorkoutBlocks._();

  static WorkoutBlocks instance = WorkoutBlocks._();

  WorkoutBlock make(String name, int seconds) {
    return WorkoutBlock(
      name: name,
      type: WorkoutType.Time,
      duration: Duration(seconds: seconds),
    );
  }

  WorkoutBlock jumpingJacks(int seconds) {
    return make('Jumping Jacks', seconds);
  }

  WorkoutBlock crunches(int seconds) {
    return make('Crunches', seconds);
  }

  WorkoutBlock russianTwists(int seconds) {
    return make('Russian Twists', seconds);
  }

  WorkoutBlock heelTouches(int seconds) {
    return make('Heel Touches', seconds);
  }

  WorkoutBlock flutterKicks(int seconds) {
    return make('Flutter Kicks', seconds);
  }

  WorkoutBlock sidePlankL(int seconds) {
    return make('Side Plank (L)', seconds);
  }

  WorkoutBlock sidePlankR(int seconds) {
    return make('Side Plank (R)', seconds);
  }

  WorkoutBlock plank(int seconds) {
    return make('Plank', seconds);
  }

  WorkoutBlock rest(int seconds) {
    return make('Rest', seconds);
  }

  WorkoutBlock highIntensity(int seconds) {
    return make('High Intensity Workout', seconds);
  }

  WorkoutBlock coolDown(int seconds) {
    return make('Cool Down', seconds);
  }

  WorkoutBlock squats(int seconds) {
    return make('Squats', seconds);
  }

  WorkoutBlock lunges(int seconds) {
    return make('Lunges', seconds);
  }
}

final _wb = WorkoutBlocks.instance;
final _make = WorkoutBlocks.instance.make;

final List<PresetWorkout> presetWorkouts = [
  PresetWorkout(
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
    'A simple 7-minute ab routine.',
  ),
  PresetWorkout(
    Workout(
      name: '20min Full-Body No-Gear',
      sequences: [
        WorkoutSequence(blocks: [
          _wb.squats(60),
          _wb.lunges(60),
          _make('Knee Push Ups', 30),
          _make('Planks', 30),
          _make('Quadruped Limb Raises', 60),
        ], repeatTimes: 5),
      ],
    ),
    'A full-body beginner workout that requires no gear.',
  ),
  PresetWorkout(
    Workout(
      name: '10min Intense Bodyweight',
      sequences: [
        WorkoutSequence(blocks: [
          _wb.squats(30),
          _make('Mountain Climbers', 30),
        ], repeatTimes: 3),
        WorkoutSequence.only(_make('Rest', 30)),
        WorkoutSequence(blocks: [
          _wb.plank(30),
          _make('Push Ups', 30),
        ], repeatTimes: 3),
        WorkoutSequence.only(_make('Rest', 30)),
        WorkoutSequence(blocks: [
          _make('Burpees', 30),
          _wb.russianTwists(30),
        ], repeatTimes: 3),
      ],
    ),
    'A grueling 10 minute intense workout that works your whole body.',
  )
];
