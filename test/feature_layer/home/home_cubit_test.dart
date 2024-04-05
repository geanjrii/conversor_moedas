import 'package:conversor_moedas/data_layer/data_layer.dart';
import 'package:conversor_moedas/domain_layer/domain_layer.dart';
import 'package:conversor_moedas/feature_layer/home/cubit/home_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  const mockCurrencyData = CurrencyData(dollar: 1, euro: 2, btc: 3);

  group('HomeCubit', () {
    late HomeCubit homeCubit;
    late MockCurrencyRepository mockCurrencyRepository;

    setUp(() {
      mockCurrencyRepository = MockCurrencyRepository();
      homeCubit = HomeCubit(repository: mockCurrencyRepository);
    });
    blocTest<HomeCubit, HomeState>(
      'emits [HomeStateSuccess] when data is fetched successfully',
      setUp: () {
        when(() => mockCurrencyRepository.getValue())
            .thenAnswer((_) => Future.value(mockCurrencyData));
      },
      build: () => homeCubit,
      act: (cubit) => cubit.onDataFetched(),
      expect: () => const [
        HomeStateSuccess(currencyData: mockCurrencyData),
      ],
      verify: (_) {
        verify(() => mockCurrencyRepository.getValue()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [HomeStateFailure] when an error occurs',
      setUp: () {
        when(() => mockCurrencyRepository.getValue())
            .thenThrow(Exception('An error occurred'));
      },
      build: () => homeCubit,
      act: (cubit) => cubit.onDataFetched(),
      expect: () => const [
        HomeStateFailure(),
      ],
      verify: (_) {
        verify(() => mockCurrencyRepository.getValue()).called(1);
      },
    );
  });
}
