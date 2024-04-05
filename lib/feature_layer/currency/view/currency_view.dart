import 'package:conversor_moedas/data_layer/data_layer.dart';
import 'package:conversor_moedas/feature_layer/currency/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/money_text_field.dart';

const Color customColor3 = Color.fromRGBO(247, 147, 27, 1);
const Color customColor2 = Colors.black;
const Color customColor = Colors.yellow;

class CurrencyPage extends StatelessWidget {
  const CurrencyPage({super.key, required this.currencyData});

  final CurrencyData currencyData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CurrencyCubit(data: currencyData),
      child: SuccessView(currencyData: currencyData),
    );
  }
}

class SuccessView extends StatefulWidget {
  final CurrencyData currencyData;

  const SuccessView({super.key, required this.currencyData});

  @override
  // ignore: library_private_types_in_public_api
  _SuccessViewState createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor2,
      appBar: AppBar(
        title: const Text(
          'BitcoinToday',
          style: TextStyle(color: customColor2),
        ),
        backgroundColor: customColor,
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MoneyIcon(),
            BtcTextField(),
            Divider(),
            DollarTextField(),
            Divider(),
            EuroTextField(),
            Divider(),
            RealTextField(),
          ],
        ),
      ),
    );
  }
}

class MoneyIcon extends StatelessWidget {
  const MoneyIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.currency_bitcoin_sharp,
      size: 150,
      color: customColor,
    );
  }
}

class BtcTextField extends StatefulWidget {
  const BtcTextField({
    super.key,
  });

  @override
  State<BtcTextField> createState() => _BtcTextFieldState();
}

class _BtcTextFieldState extends State<BtcTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = context.watch<CurrencyCubit>().state.btc.value;
    final erro = context.watch<CurrencyCubit>().state.btc.displayError;
    return MoneyTextField(
      errorText: erro != null ? 'somente números' : null,
      label: 'Bitcoin',
      prefixText: 'BTC ',
      controller: _controller,
      onChanged: (value) => context.read<CurrencyCubit>().onBtcChanged(value),
      onSubmitted: context.read<CurrencyCubit>().onClearRequested,
      customColor: customColor,
    );
  }
}

class DollarTextField extends StatefulWidget {
  const DollarTextField({
    super.key,
  });

  @override
  State<DollarTextField> createState() => _DollarTextFieldState();
}

class _DollarTextFieldState extends State<DollarTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = context.watch<CurrencyCubit>().state.dollar.value;
    final erro = context.read<CurrencyCubit>().state.dollar.displayError;
    return MoneyTextField(
      errorText: erro != null ? 'somente números' : null,
      label: 'Dolares',
      prefixText: 'US\$ ',
      controller: _controller,
      onChanged: (value) => context.read<CurrencyCubit>().onDolarChanged(value),
      onSubmitted: context.read<CurrencyCubit>().onClearRequested,
      customColor: customColor,
    );
  }
}

class EuroTextField extends StatefulWidget {
  const EuroTextField({
    super.key,
  });

  @override
  State<EuroTextField> createState() => _EuroTextFieldState();
}

class _EuroTextFieldState extends State<EuroTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = context.watch<CurrencyCubit>().state.euro.value;
    final erro = context.read<CurrencyCubit>().state.euro.displayError;
    return MoneyTextField(
      errorText: erro != null ? 'somente números' : null,
      label: 'Euros',
      prefixText: '€ ',
      controller: _controller,
      onChanged: (value) => context.read<CurrencyCubit>().onEuroChanged(value),
      onSubmitted: context.read<CurrencyCubit>().onClearRequested,
      customColor: customColor,
    );
  }
}

class RealTextField extends StatefulWidget {
  const RealTextField({
    super.key,
  });

  @override
  State<RealTextField> createState() => _RealTextFieldState();
}

class _RealTextFieldState extends State<RealTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = context.watch<CurrencyCubit>().state.real.value;
    final erro = context.read<CurrencyCubit>().state.real.displayError;
    return MoneyTextField(
      errorText: erro != null ? 'somente números' : null,
      label: 'Reais',
      prefixText: 'R\$ ',
      controller: _controller,
      onChanged: (value) => context.read<CurrencyCubit>().onRealChanged(value),
      onSubmitted: context.read<CurrencyCubit>().onClearRequested,
      customColor: customColor,
    );
  }
}
