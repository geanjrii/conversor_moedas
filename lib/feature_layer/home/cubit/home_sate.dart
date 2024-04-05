part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeStateLoading extends HomeState {
  const HomeStateLoading();
}

final class HomeStateFailure extends HomeState {
  const HomeStateFailure();
}

final class HomeStateSuccess extends HomeState {
  const HomeStateSuccess({
    required this.currencyData,
  });

  final CurrencyData currencyData;

  @override
  List<Object> get props => [currencyData];
}
