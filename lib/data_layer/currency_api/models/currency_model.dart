import 'package:equatable/equatable.dart';

class CurrencyData extends Equatable {
  final double dollar;
  final double euro;
  final double btc;

  const CurrencyData({
    required this.dollar,
    required this.euro,
    required this.btc,
  });

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      dollar: json['results']['currencies']['USD']['buy'] ?? '',
      euro: json['results']['currencies']['EUR']['buy'] ?? '',
      btc: json['results']['currencies']['BTC']['buy'] ?? '',
    );
  }

  factory CurrencyData.empty() {
    return const CurrencyData(dollar: 0, euro: 0, btc: 0);
  }

  @override
  List<Object> get props => [dollar, euro, btc];
}
