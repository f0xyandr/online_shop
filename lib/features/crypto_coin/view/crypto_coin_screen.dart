import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/crypto_coin/bloc/crypto_coin_details_bloc.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';

@RoutePage()
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key, required this.cryptoCoin});

  final CryptoCoin cryptoCoin;

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  // CryptoCoin? coin;
  final _cryptoCoinDetailsBloc =
      CryptoCoinDetailsBloc(GetIt.I<AbstractCoinsRepository>());
  @override
  void initState() {
    _cryptoCoinDetailsBloc
        .add(LoadCryptoCoinDetails(currencyCode: widget.cryptoCoin.name));

    super.initState();
  }
  // void didChangeDependencies() {
  //   final args = ModalRoute.of(context)?.settings.arguments;
  //   assert(args != null && args is CryptoCoin, 'You must provide String args');
  //   coin = args as CryptoCoin;
  //   setState(() {});
  //   _cryptoCoinDetailsBloc.add(LoadCryptoCoinDetails(currencyCode: coin!.name));
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: BlocBuilder<CryptoCoinDetailsBloc, CryptoCoinDetailsState>(
        bloc: _cryptoCoinDetailsBloc,
        builder: (context, state) {
          if (state is CryptoCoinDetailsLoaded) {
            final coin = state.coin;
            final coinDetails = coin.details;
            return Center(
              child: Scaffold(
                body: Column(
                  children: [
                    TextButton(
                        onPressed: () {}, child: const Text("transition")),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            SizedBox(
                                width: 350,
                                height: 200,
                                child: Image.network(
                                  coinDetails.fullImageUrl,
                                )),
                            Text(coin.name),
                            Card(
                                color: Colors.black,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: SizedBox(
                                  height: 70,
                                  width: 450,
                                  child: coinDetails.priceInUSD > 1
                                      ? Center(
                                          child: Text(
                                              "≈ ${coinDetails.priceInUSD.toStringAsFixed(2)} \$",
                                              style: theme
                                                  .textTheme.headlineMedium),
                                        )
                                      : Center(
                                          child: Text(
                                            "≈ ${coinDetails.priceInUSD} \$",
                                            style: theme.textTheme.labelSmall,
                                          ),
                                        ),
                                )),
                          ],
                        )),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              color: Colors.black,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: SizedBox(
                                height: 60,
                                width: 210,
                                child: Column(
                                  children: [
                                    const Text("HIGH 24 HOUR"),
                                    Text("${coinDetails.high24hour} \$"),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                                color: Colors.black,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: SizedBox(
                                  height: 60,
                                  width: 210,
                                  child: Column(
                                    children: [
                                      const Text("LOW 24 HOUR"),
                                      Text("${coinDetails.low24hour} \$"),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
