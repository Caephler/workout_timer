enum ExerciseType {
  Core,
  Leg,
  Arm,
  Yoga,
}

class ExerciseMaster {
  ExerciseMaster._();

  static ExerciseMaster instance = ExerciseMaster._();

  final List<String> _coreExercises = [
    'Plank',
    'Plank Jacks',
    'Crunches',
    'Bicycle Crunches',
    'Leg Lifts',
    'Russian Twists',
    'Toe Touches',
    'Heel Taps',
    'Side Plank (L)',
    'Side Plank (R)',
  ];
  final List<String> _legExercises = [
    'Squats',
    'Lunges',
    'Wide Squat',
    'Bulgarian Split Squat',
    'Glute Bridge',
    'Jump Squat',
    'Single Leg Deadlift',
  ];
  final List<String> _armExercises = [
    'Push Ups',
    'Tricep Dips',
    'Knee Push Ups',
    'Inclined Push Ups',
    'Inchworm',
  ];
  final List<String> _yogaExercises = [
    'Mountain Pose',
    'Chair Pose',
    'Downward Dog',
    'Triangle Pose',
    'Tree Pose',
    'Bridge Pose',
    'Seated Forward Hold',
    'Upward-Facing Dog',
    'Half Moon Pose',
    'Dolphin Pose',
    'Camel Pose',
    'Boat Pose',
    'Crow Pose',
    'Wheel Pose',
    'Handstand',
    'Headstand'
  ];

  List<String> get allExercises {
    List<String> exerciseList = [
      ..._coreExercises,
      ..._legExercises,
      ..._armExercises,
      ..._yogaExercises
    ];

    exerciseList.sort();

    return exerciseList;
  }

  final Map<String, String> _exerciseImages = {
    /// Core
    // 'plank': '',
    // 'plank jacks': '',
    // 'crunches': '',
    // 'bicycle crunches': '',
    // 'leg lifts': '',
    // 'russian twists': '',
    // 'toe touches': '',
    // 'heel taps': '',
    // 'side plank (l)': '',
    // 'side plank (r)': '',

    /// Leg
    // 'squats': '',
    // 'lunges': '',
    // 'wide squat': '',
    // 'bulgarian split squat': '',
    // 'glute bridge': '',
    // 'jump squat': '',
    // 'single leg deadlift': '',

    /// Arm
    // 'push ups': '',
    // 'tricep dips': '',
    // 'knee push ups': '',
    // 'inclined push ups': '',
    // 'inchworm': '',

    /// Yoga
    // 'mountain pose': '',
    // 'chair pose': '',
    // 'downward dog': '',
    // 'triangle pose': '',
    // 'tree pose': '',
    // 'bridge pose': '',
    // 'seated forward hold': '',
    // 'upward-facing dog': '',
    // 'half moon pose': '',
    // 'dolphin pose': '',
    // 'camel pose': '',
    // 'boat pose': '',
    // 'crow pose': '',
    // 'wheel pose': '',
    // 'handstand': '',
    // 'headstand': '',
  };

  List<String> get coreExercises {
    return _coreExercises;
  }

  List<String> get legExercises {
    return _legExercises;
  }

  List<String> get armExercises {
    return _armExercises;
  }

  List<String> get yogaExercises {
    return _yogaExercises;
  }

  String? getExerciseImageFor(String exercise) {
    return _exerciseImages[exercise.toLowerCase()];
  }

  List<String> getExercises(String name, Set<ExerciseType> type) {
    List<String> resultList = [];
    if (type.contains(ExerciseType.Core)) {
      resultList.addAll(coreExercises);
    }
    if (type.contains(ExerciseType.Leg)) {
      resultList.addAll(legExercises);
    }
    if (type.contains(ExerciseType.Arm)) {
      resultList.addAll(armExercises);
    }
    if (type.contains(ExerciseType.Yoga)) {
      resultList.addAll(yogaExercises);
    }

    return resultList
        .where((element) =>
            name.toLowerCase().allMatches(element.toLowerCase()).isNotEmpty)
        .toList();
  }
}
