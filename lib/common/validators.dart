import 'extensions.dart';
import 'package:validators/validators.dart';

class ValidatorResult {
  final bool isValid;
  final List<String> errors;

  ValidatorResult(this.isValid, this.errors);

  ValidatorResult combine(ValidatorResult other) {
    return ValidatorResult(isValid && other.isValid, [
      ...errors,
      ...other.errors,
    ]);
  }

  @override
  String toString() {
    return 'ValidatorResult { isValid: $isValid, errors: $errors }';
  }
}

typedef Validator<T> = ValidatorResult Function(T value);

/// Validates the string with all the validators, and returns a validator result that
/// combines all the error messages
ValidatorResult validateAll<T>({
  T? value,
  Iterable<Validator<T>> validators = const [],
}) {
  if (value == null) {
    return ValidatorResult(
      false,
      [
        'No value provided',
      ],
    );
  }
  return validators.foldRight(
    (accumulator, element) => accumulator.combine(element(value)),
    ValidatorResult(
      true,
      [],
    ),
  );
}

Validator<String> createLengthValidator(int min, int max, String? error) {
  return (value) {
    bool isValid = isLength(value, min, max);
    return ValidatorResult(
      isValid,
      isValid
          ? []
          : [
              error ??
                  'Input must be in between $min and $max characters long.',
            ],
    );
  };
}
