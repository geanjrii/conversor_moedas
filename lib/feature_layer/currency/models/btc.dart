import 'package:formz/formz.dart';

enum BtcValidationError { invalid }

class Btc extends FormzInput<String, BtcValidationError> {
  const Btc.pure() : super.pure('');

  const Btc.dirty([super.value = '']) : super.dirty();

  static final RegExp _btcRegExp = RegExp(r'^$|^\d*\.?\d*$');

  @override
  BtcValidationError? validator(String? value) {
    return _btcRegExp.hasMatch(value ?? '') ? null : BtcValidationError.invalid;
  }
}
