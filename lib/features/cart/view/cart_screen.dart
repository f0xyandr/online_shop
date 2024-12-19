import 'package:crypto_coins_list/features/cart/cart.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _cartBloc = CartBloc(GetIt.I<ProductsRepository>());
  @override
  void initState() {
    _cartBloc.add(LoadCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
          bloc: _cartBloc,
          builder: (context, state) {
            if (state is CartLoaded) Text("YEAH BABY");
            return CircularProgressIndicator();
          }),
    );
  }
}
