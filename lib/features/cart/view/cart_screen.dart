import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/cart/cart.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
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
            if (state is CartLoaded) {
              final List cartItemsList = state.cartItemsList;
              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: cartItemsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${cartItemsList[index].product.name}"),
                      subtitle: Text("${cartItemsList[index].quantity}"),
                    );
                  });
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
