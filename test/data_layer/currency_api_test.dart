import 'dart:convert';

import 'package:conversor_moedas/data_layer/data_layer.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockHttpResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  const mockJson = {
    "results": {
      "currencies": {
        "USD": {"buy": 5.0},
        "EUR": {"buy": 6.0},
        "BTC": {"buy": 50000.0}
      }
    }
  };

  late CurrencyApi currencyApi;
  late MockHttpClient mockHttpClient;
  late MockHttpResponse mockResponse;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockResponse = MockHttpResponse();
    currencyApi = CurrencyApi(client: mockHttpClient);
  });

  registerFallbackValue(Uri());

  test('getCurrencyValues returns CurrencyData when API call is successful',
      () async {
    final jsonCurrencyDAta = jsonEncode(mockJson);
    when(() => mockResponse.statusCode).thenReturn(200);
    when(() => mockResponse.body).thenReturn(jsonCurrencyDAta);
    when(() => mockHttpClient.get(any())).thenAnswer((_) async => mockResponse);

    final result = await currencyApi.getCurrencyValues();
    expect(result, isA<CurrencyData>());
    expect(result.dollar, equals(5.0));
    expect(result.euro, equals(6.0));
    expect(result.btc, equals(50000.0));
  });

  test(
      'getCurrencyValues throws CurrencyNotFoundException when Status code is not 200',
      () async {
    when(() => mockResponse.statusCode).thenReturn(400);
    when(() => mockHttpClient.get(any())).thenAnswer((_) async => mockResponse);
    expect(
      () async => currencyApi.getCurrencyValues(),
      throwsA(isA<CurrencyNotFoundException>()),
    );
  });

  test(
      'getCurrencyValues throws CurrencyFormatException when API response is invalid',
      () async {
    when(() => mockResponse.statusCode).thenReturn(200);
    when(() => mockResponse.body).thenReturn('{}');
    when(() => mockHttpClient.get(any())).thenAnswer((_) async => mockResponse);
    expect(() async => currencyApi.getCurrencyValues(),
        throwsA(isA<CurrencyFormatException>()));
  });
}
