import 'package:flutter/material.dart';
import 'package:workout_timer/common/button.dart';
import 'package:workout_timer/common/validators.dart';

Future<void> showDialogOf<T>(
  BuildContext context, {
  required T defaultValue,
  required Widget Function(
    FormFieldState<T> builder,
    void Function() commitChange,
  )
      buildContent,
  String title = 'Input',
  String? helpText,
  void Function(T value)? onOk,
  void Function()? onCancel,
  Iterable<Validator<T>>? validators,
  ButtonType okType = ButtonType.primary,
  ButtonType cancelType = ButtonType.text,
  String okLabel = 'OK',
  String cancelLabel = 'Cancel',
}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return _GenericDialog(
        title: title,
        defaultValue: defaultValue,
        helpText: helpText,
        onOk: onOk,
        onCancel: onCancel,
        validators: validators,
        buildContent: buildContent,
        okType: okType,
        cancelType: cancelType,
        okLabel: okLabel,
        cancelLabel: cancelLabel,
      );
    },
  );
}

class _GenericDialog<T> extends SimpleDialog {
  _GenericDialog({
    required String title,
    required T defaultValue,
    void Function(T value)? onOk,
    void Function()? onCancel,
    String? helpText,
    Iterable<Validator<T>>? validators,
    required Widget Function(
            FormFieldState<T> context, void Function() commitChange)
        buildContent,
    ButtonType okType = ButtonType.text,
    ButtonType cancelType = ButtonType.text,
    String okLabel = 'OK',
    String cancelLabel = 'Cancel',
  }) : super(
          title: Text(title),
          children: [
            _GenericDialogContent(
              defaultValue: defaultValue,
              onOk: onOk,
              onCancel: onCancel,
              validators: validators,
              buildContent: buildContent,
              helpText: helpText,
              okType: okType,
              cancelType: cancelType,
              okLabel: okLabel,
              cancelLabel: cancelLabel,
            ),
          ],
        );
}

class _GenericDialogContent<T> extends StatefulWidget {
  const _GenericDialogContent({
    required this.defaultValue,
    this.onOk,
    this.onCancel,
    this.validators,
    this.helpText,
    required this.buildContent,
    required this.okType,
    required this.cancelType,
    required this.okLabel,
    required this.cancelLabel,
  });

  final T defaultValue;
  final String? helpText;
  final void Function(T value)? onOk;
  final void Function()? onCancel;
  final Iterable<Validator<T>>? validators;
  final Widget Function(FormFieldState<T> context, void Function() commitChange)
      buildContent;
  final ButtonType okType;
  final ButtonType cancelType;
  final okLabel;
  final cancelLabel;

  @override
  _GenericDialogContentState<T> createState() =>
      _GenericDialogContentState<T>();
}

class _GenericDialogContentState<T> extends State<_GenericDialogContent<T>> {
  final _formKey = GlobalKey<FormState>();
  T? value;

  @override
  void initState() {
    super.initState();
    value = widget.defaultValue;
  }

  void _commitChange() {
    bool isValid = _formKey.currentState?.validate() ?? true;
    if (isValid) {
      _formKey.currentState?.save();
      widget.onOk?.call(value!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          widget.helpText != null ? Text(widget.helpText!) : SizedBox.shrink(),
          Form(
            key: _formKey,
            child: FormField<T>(
              initialValue: value,
              onSaved: (value) {
                setState(() {
                  this.value = value;
                });
              },
              builder: (builder) {
                return widget.buildContent(builder, _commitChange);
              },
              validator: (value) {
                ValidatorResult result = validateAll<T>(
                  value: value,
                  validators: widget.validators ?? [],
                );

                if (!result.isValid) {
                  return result.errors.first;
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _getButtonWith(
                onPressed: () {
                  widget.onCancel?.call();
                  Navigator.pop(context);
                },
                child: Text(widget.cancelLabel),
                type: widget.cancelType,
              ),
              SizedBox(width: 16.0),
              _getButtonWith(
                onPressed: () {
                  _commitChange();
                },
                child: Text(widget.okLabel),
                type: widget.okType,
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget _getButtonWith({
  required Widget child,
  VoidCallback? onPressed,
  required ButtonType type,
}) {
  if (type != ButtonType.text) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        primary: type == ButtonType.primary
            ? Colors.blue
            : type == ButtonType.warning
                ? Colors.amber
                : type == ButtonType.danger
                    ? Colors.red
                    : Colors.blue,
      ),
    );
  }
  return TextButton(onPressed: onPressed, child: child);
}
