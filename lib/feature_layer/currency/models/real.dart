import 'package:formz/formz.dart';

enum RealValidationError { invalid }

class Real extends FormzInput<String, RealValidationError> {
  const Real.pure() : super.pure('');

  const Real.dirty([super.value = '']) : super.dirty();

  static final RegExp _realRegExp = RegExp(r'^$|^\d*\.?\d*$');

  @override
  RealValidationError? validator(String? value) {
    return _realRegExp.hasMatch(value ?? '')
        ? null
        : RealValidationError.invalid;
  }
}
