import 'package:formz/formz.dart';

enum DollarValidationError { invalid }

class Dollar extends FormzInput<String, DollarValidationError> {
  const Dollar.pure() : super.pure('');

  const Dollar.dirty([super.value = '']) : super.dirty();

  static final RegExp _dollarRegExp = RegExp(r'^$|^\d*\.?\d*$');

  @override
  DollarValidationError? validator(String? value) {
    return _dollarRegExp.hasMatch(value ?? '')
        ? null
        : DollarValidationError.invalid;
  }
}
