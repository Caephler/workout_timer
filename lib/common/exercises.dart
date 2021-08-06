enum ExerciseType {
  Core,
  Leg,
  Arm,
  Yoga,
  FullBody,
}

class ExerciseMaster {
  ExerciseMaster._();

  static ExerciseMaster instance = ExerciseMaster._();

  final List<String> _commonExercises = [
    'Rest',
  ];

  final Set<String> _fullBodyExercises = {
    'Bounds',
    'Box Jumps',
    'Burpee',
    'Crab Crawl',
    'Frogger',
    'High Knees',
    'Jump Rope',
    'Jumping Jacks',
    'Mountain Climbers',
    'Star Jump',
    'Twisted Mountain Climber'
  };

  final Set<String> _coreExercises = {
    'Plank',
    'Plank Jacks',
    'Crunches',
    'Bicycle Crunches',
    'Leg Lifts',
    'Russian Twists',
    'Toe Touches',
    'Heel Taps',
    'Leg Raises',
    'Mountain Climbers',
    'Side Plank (L)',
    'Side Plank (R)',
    'Superman',
  };

  final Set<String> _legExercises = {
    'Squats',
    'Lunges',
    'Wide Squat',
    'Bulgarian Split Squat',
    'Glute Bridge',
    'Jump Squat',
    'Single Leg Deadlift',
    'Box Toe Touches',
    'Butt Kickers',
    'Calf Raises',
    'Goblet Squat',
    'Skaters',
    'Squat Jump',
    'Standing Leg Lift',
    'Quadruped Limb Raises',
  };

  final Set<String> _armExercises = {
    'Bicep Curls',
    'Push Ups',
    'Tricep Dips',
    'Knee Push Ups',
    'Inclined Push Ups',
    'Inchworm',
    'Chest Press',
    'Shoulder Press',
  };

  final Set<String> _yogaExercises = {
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
  };

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

    /// Common
    // 'rest': '',
  };

  String? getExerciseImageFor(String exercise) {
    // First check images
    String? firstPriorityImage = _exerciseImages[exercise.toLowerCase()];
    if (firstPriorityImage != null) {
      return firstPriorityImage;
    }

    // Second, check whether it is in one of our types
    bool isArm = _armExercises.contains(exercise);
    if (isArm) {
      // TODO: Replace with generic image of arm
      return null;
    }

    bool isLeg = _legExercises.contains(exercise);
    if (isLeg) {
      // TODO: Replace with generic image of leg
      return null;
    }

    // Second, check whether it is in one of our types
    bool isCore = _coreExercises.contains(exercise);
    if (isCore) {
      // TODO: Replace with generic image of core
      return null;
    }

    bool isYoga = _legExercises.contains(exercise);
    if (isYoga) {
      // TODO: Replace with generic image of yoga
      return null;
    }

    return null;
  }

  List<String> getExercises(String name, Set<ExerciseType> type) {
    List<String> resultList = [];
    if (type.contains(ExerciseType.Core)) {
      resultList.addAll(_coreExercises);
    }
    if (type.contains(ExerciseType.Leg)) {
      resultList.addAll(_legExercises);
    }
    if (type.contains(ExerciseType.Arm)) {
      resultList.addAll(_armExercises);
    }
    if (type.contains(ExerciseType.Yoga)) {
      resultList.addAll(_yogaExercises);
    }
    if (type.contains(ExerciseType.FullBody)) {
      resultList.addAll(_fullBodyExercises);
    }

    return resultList
        .where((element) =>
            name.toLowerCase().allMatches(element.toLowerCase()).isNotEmpty)
        .toList();
  }

  List<String> getCommonExercises() {
    return _commonExercises;
  }
}
