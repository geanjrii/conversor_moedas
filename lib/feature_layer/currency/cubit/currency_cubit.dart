import 'package:conversor_moedas/data_layer/data_layer.dart';
import 'package:conversor_moedas/feature_layer/currency/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final CurrencyData data;

  CurrencyCubit({required this.data}) : super(const CurrencyState());

  void onBtcChanged(String text) {
    final real = state.real;
    final dollar = state.dollar;
    final euro = state.euro;
    final btc = Btc.dirty(text);
    final bool isInvalid = !Formz.validate([real, dollar, euro, btc]);
    emit(state.copyWith(btc: btc));

    if (isInvalid) {
      return;
    } else if (text.isEmpty) {
      onClearRequested();
      return;
    } else {
      final double btc = double.tryParse(text) ?? 0;
      final String real = (btc * data.btc).toStringAsFixed(2);
      final String dollar = (btc * data.btc / data.dollar).toStringAsFixed(2);
      final String euro = (btc * data.btc / data.euro).toStringAsFixed(2);

      emit(state.copyWith(
        real: Real.dirty(real),
        dollar: Dollar.dirty(dollar),
        euro: Euro.dirty(euro),
      ));
    }
  }

  void onDolarChanged(String text) {
    final real = state.real;
    final dollar = Dollar.dirty(text);
    final euro = state.euro;
    final btc = state.btc;
    final bool isInvalid = !Formz.validate([real, dollar, euro, btc]);
    emit(state.copyWith(dollar: dollar));

    if (isInvalid) {
      return;
    } else if (text.isEmpty) {
      onClearRequested();
      return;
    } else {
      final double dollar = double.tryParse(text) ?? 0;
      final String real = (dollar * data.dollar).toStringAsFixed(2);
      final String euro = (dollar * data.dollar / data.euro).toStringAsFixed(2);
      final String btc = (dollar * data.dollar / data.btc).toStringAsFixed(2);

      emit(state.copyWith(
        real: Real.dirty(real),
        euro: Euro.dirty(euro),
        btc: Btc.dirty(btc),
      ));
    }
  }

  void onEuroChanged(String text) {
    final real = state.real;
    final dollar = state.dollar;
    final euro = Euro.dirty(text);
    final btc = state.btc;
    final bool isInvalid = !Formz.validate([real, dollar, euro, btc]);
    emit(state.copyWith(euro: euro));

    if (isInvalid) {
      return;
    } else if (text.isEmpty) {
      onClearRequested();
      return;
    } else {
      final double euro = double.tryParse(text) ?? 0;
      final String real = (euro * data.euro).toStringAsFixed(2);
      final String dollar = (euro * data.euro / data.dollar).toStringAsFixed(2);
      final String btc = (euro * data.euro / data.btc).toStringAsFixed(2);

      emit(state.copyWith(
          real: Real.dirty(real),
          dollar: Dollar.dirty(dollar),
          btc: Btc.dirty(btc)));
    }
  }

  void onRealChanged(String text) {
    final real = Real.dirty(text);
    final dollar = state.dollar;
    final euro = state.euro;
    final btc = state.btc;
    final bool isInvalid = !Formz.validate([real, dollar, euro, btc]);
    emit(state.copyWith(real: Real.dirty(text)));

    if (isInvalid) {
      return;
    } else if (text.isEmpty) {
      onClearRequested();
      return;
    } else {
      final double real = double.tryParse(text) ?? 0;
      final String dollar = (real / data.dollar).toStringAsFixed(2);
      final String euro = (real / data.euro).toStringAsFixed(2);
      final String btc = (real / data.btc).toStringAsFixed(2);

      emit(state.copyWith(
          dollar: Dollar.dirty(dollar),
          euro: Euro.dirty(euro),
          btc: Btc.dirty(btc)));
    }
  }

  void onClearRequested() {
    emit(const CurrencyState());
  }
}
