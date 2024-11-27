import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/product/bloc/product_bloc.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _productBloc = ProductBloc(GetIt.I<ProductsRepository>());

  @override
  void initState() {
    _productBloc.add(LoadProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ProductBloc, ProductState>(
            bloc: _productBloc,
            builder: (context, state) {
              if (state is ProductLoaded) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30),
                  itemCount: state.productList.length,
                  itemBuilder: ((context, index) {
                    final productItem = state.productList[index];
                    return ListTile(
                      title: Center(
                          child: Column(
                        children: [
                          Text(productItem.name),
                          Text(productItem.id.toString()),
                          Text(productItem.price.toString()),
                        ],
                      )),
                      tileColor: Colors.white,
                    );
                  }),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }));
  }
}
// FutureBuilder(
      //     future: future,
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData) {
      //         return const Center(child: CircularProgressIndicator());
      //       }
      //       final products = snapshot.data!;
            
      //       return GridView.builder(
      //         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //             maxCrossAxisExtent: 300,
      //             mainAxisSpacing: 30,
      //             crossAxisSpacing: 30),
      //         itemCount: products.length,
      //         itemBuilder: ((context, index) {
      //           final productItem = products[index];
      //           return ListTile(
      //             title: Center(
      //                 child: Column(
      //               children: [
      //                 Text(productItem['name']),
      //               ],
      //             )),
      //             tileColor: Colors.white,
      //           );
      //         }),
      //       );
      //     }),