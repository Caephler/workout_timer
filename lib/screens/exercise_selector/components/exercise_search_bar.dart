import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/muted_label.dart';
import 'package:workout_timer/common/text.dart';
import 'package:workout_timer/screens/exercise_selector/components/category_selector.dart';
import 'package:workout_timer/screens/exercise_selector/cubit/exercise_selector_cubit.dart';

class ExerciseSearchBar extends StatefulWidget {
  ExerciseSearchBar({Key? key, required this.onSave}) : super(key: key);

  final void Function(BuildContext context) onSave;

  @override
  State<ExerciseSearchBar> createState() => _ExerciseSearchBarState();
}

class _ExerciseSearchBarState extends State<ExerciseSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    String name = context.read<ExerciseSelectorCubit>().state.name;
    _controller.text = name;
  }

  @override
  Widget build(BuildContext context) {
    String errorMessage =
        context.select((ExerciseSelectorCubit cubit) => cubit.state.error);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MutedLabel('Edit Workout Name'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    controller: _controller,
                    onChanged: (value) {
                      context.read<ExerciseSelectorCubit>().updateName(value);
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _controller.clear();
                          context.read<ExerciseSelectorCubit>().updateName('');
                        },
                        icon: Icon(LineIcons.times),
                      ),
                      errorText: errorMessage.length > 0 ? errorMessage : null,
                      errorStyle: AppTextStyles.body.getStyleFor(5),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () => widget.onSave(context),
                  child: Text(
                    'Save',
                    style: AppTextStyles.body.getStyleFor(5),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48.0, child: CategorySelector()),
          ],
        ),
      ),
    );
  }
}
