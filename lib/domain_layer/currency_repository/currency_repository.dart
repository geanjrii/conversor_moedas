import 'package:conversor_moedas/data_layer/data_layer.dart';

class CurrencyRepository {
  final CurrencyApi _api;

  CurrencyRepository({required CurrencyApi api}) : _api = api;

  Future<CurrencyData> getValue() {
    return _api.getCurrencyValues();
  }
}
