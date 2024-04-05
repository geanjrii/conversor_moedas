part of 'currency_cubit.dart';

class CurrencyState extends Equatable {
  final Real real;

  final Dollar dollar;

  final Euro euro;

  final Btc btc;

  const CurrencyState ({
    this.real = const Real.pure(),
    this.dollar = const Dollar.pure(),
    this.euro = const Euro.pure(),
    this.btc = const Btc.pure(),
  });

   

  CurrencyState copyWith({
    Real? real,
    Dollar? dollar,
    Euro? euro,
    Btc? btc,
    bool? isValid,
  }) {
    return CurrencyState (
      real: real ?? this.real,
      dollar: dollar ?? this.dollar,
      euro: euro ?? this.euro,
      btc: btc ?? this.btc,
    );
  }

  @override
  List<Object> get props => [real, dollar, euro, btc];
}
