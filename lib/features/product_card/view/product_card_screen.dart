import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/product_card/bloc/product_card_bloc.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_coins_list/repositories/products/models/models.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class ProductCardScreen extends StatefulWidget {
  const ProductCardScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductCardScreen> createState() => _ProductCardScreenState();
}

class _ProductCardScreenState extends State<ProductCardScreen> {
  final _productCardBloc = ProductCardBloc(GetIt.I<ProductsRepository>());

  @override
  void initState() {
    _productCardBloc.add(LoadProductCard(widget.product));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ProductCardBloc, ProductCardState>(
            bloc: _productCardBloc,
            builder: (context, state) {
              if (state is ProductCardLoaded) {
                return const Center(
                  child: Text(
                    "you got it",
                    style: TextStyle(fontSize: 50),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}
