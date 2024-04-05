import 'package:conversor_moedas/data_layer/currency_api/models/currency_model.dart';
import 'package:conversor_moedas/domain_layer/currency_repository/currency_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_sate.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required CurrencyRepository repository})
      : _repository = repository,
        super(const HomeStateLoading());

  final CurrencyRepository _repository;

  void onDataFetched() async {
    try {
      final currencyData = await _repository.getValue();
      emit(HomeStateSuccess(currencyData: currencyData));
    } catch (_) {
      emit(const HomeStateFailure());
    }
  }
}
