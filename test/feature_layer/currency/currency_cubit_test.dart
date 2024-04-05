import 'package:conversor_moedas/data_layer/data_layer.dart';
import 'package:conversor_moedas/feature_layer/currency/cubit/currency_cubit.dart';
import 'package:conversor_moedas/feature_layer/currency/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyData extends Mock implements CurrencyData {}

void main() {
  group('CurrencyCubit', () {
    late CurrencyCubit currencyCubit;
    late MockCurrencyData mockCurrencyData;

    setUp(() {
      mockCurrencyData = MockCurrencyData();
      currencyCubit = CurrencyCubit(data: mockCurrencyData);
    });

    tearDown(() {
      currencyCubit.close();
    });

    test('initial state is CurrencyState.empty()', () {
      expect(currencyCubit.state, const CurrencyState());
    });

    

    blocTest<CurrencyCubit, CurrencyState>(
      'emits CurrencyState.empty() when onClearRequested is called',
      build: () => currencyCubit,
      seed: () => const CurrencyState(
        real: Real.dirty('10'),
        dollar: Dollar.dirty('20'),
        euro: Euro.dirty('30'),
        btc: Btc.dirty('40'),
      ),
      act: (cubit) => cubit.onClearRequested(),
      expect: () => [
        const CurrencyState(),
      ],
    );
  });
}
