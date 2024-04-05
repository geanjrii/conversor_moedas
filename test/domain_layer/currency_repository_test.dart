import 'package:conversor_moedas/data_layer/data_layer.dart';
import 'package:conversor_moedas/domain_layer/domain_layer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockCurrencyApi extends Mock implements CurrencyApi {}

void main() {
  const mockCurrency = CurrencyData(dollar: 0, euro: 0, btc: 0);

  group('CurrencyRepository', () {
    late CurrencyRepository currencyRepository;
    late MockCurrencyApi mockCurrencyApi;

    setUp(() {
      mockCurrencyApi = MockCurrencyApi();
      currencyRepository = CurrencyRepository(api: mockCurrencyApi);
    });

    test('return currency data from CurrencyApi',
        () async {
      when(() => mockCurrencyApi.getCurrencyValues())
          .thenAnswer((_) => Future.value(mockCurrency));
      final actual = await currencyRepository.getValue();
      expect(actual.dollar, 0);
      expect(actual.euro, 0);
      expect(actual.btc, 0);
      verify(() => mockCurrencyApi.getCurrencyValues()).called(1);
    });
  });
}
