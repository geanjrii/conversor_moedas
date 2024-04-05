import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/currency_model.dart';

class CurrencyApi {
  final http.Client client;

  CurrencyApi({http.Client? client}) : client = client ?? http.Client();

  Future<CurrencyData> getCurrencyValues() async {
    const url = 'https://api.hgbrasil.com/finance?key=669fb7d2';
    final response = await client.get(Uri.parse(url));
    if (response.statusCode != 200) return throw CurrencyNotFoundException();

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (data
        case {
          "results": {
            "currencies": {
              "USD": {"buy": double? dollar},
              "EUR": {"buy": double? euro},
              "BTC": {"buy": double? btc}
            }
          }
        } when (dollar != null && euro != null && btc != null)) {
      return CurrencyData.fromJson(data);
    } else {
      throw CurrencyFormatException();
    }
  }
}

class CurrencyNotFoundException implements Exception {}

class CurrencyFormatException implements Exception {}
