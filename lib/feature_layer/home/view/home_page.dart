import 'package:conversor_moedas/data_layer/currency_api/currency_api.dart';
import 'package:conversor_moedas/domain_layer/currency_repository/currency_repository.dart';
import 'package:conversor_moedas/feature_layer/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../currency/view/currency_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeCubit(repository: CurrencyRepository(api: CurrencyApi()))
            ..onDataFetched(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return switch (state) {
          HomeStateLoading() => const Loading(),
          HomeStateFailure() => const ErrorPage(),
          HomeStateSuccess() => CurrencyPage(currencyData: state.currencyData),
        };
      },
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Erro ao carregar!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Carregando dados...',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
