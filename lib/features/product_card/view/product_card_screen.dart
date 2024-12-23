import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/product_card/bloc/product_card_bloc.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:crypto_coins_list/features/cart/cart.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_coins_list/repositories/products/models/models.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    final Map<int, Product> productEntries = {
      widget.product.id: widget.product
    };
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ProductCardBloc, ProductCardState>(
            bloc: _productCardBloc,
            builder: (context, state) {
              if (state is ProductCardLoaded) {
                return Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () async {
                          final userId =
                              Supabase.instance.client.auth.currentUser!.id;

                          try {
                            await Supabase.instance.client.from('cart').insert({
                              'user': userId,
                              'product_id': widget.product.id,
                            });
                            debugPrint("Товар добавлен в корзину.");
                          } catch (e) {
                            debugPrint("Ошибка при добавлении товара: $e");
                          }

                          // debugPrint("${users.first.values.contains(userId)}");
                        },
                        child: const Text(
                          "you got it",
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            AutoRouter.of(context).push(CartRoute());
                          },
                          child: Text("to cart")),
                    ],
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
