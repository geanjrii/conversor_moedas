import 'package:formz/formz.dart';

enum EuroValidationError { invalid }

class Euro extends FormzInput<String, EuroValidationError> {
  const Euro.pure() : super.pure('');

  const Euro.dirty([super.value = '']) : super.dirty();

  static final RegExp _euroRegExp = RegExp(r'^$|^\d*\.?\d*$');

  @override
  EuroValidationError? validator(String? value) {
    return _euroRegExp.hasMatch(value ?? '')
        ? null
        : EuroValidationError.invalid;
  }
}
