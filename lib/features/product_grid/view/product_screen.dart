import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/product_add/product_add.dart';
import 'package:crypto_coins_list/features/product_grid/bloc/product_bloc.dart';
import 'package:crypto_coins_list/features/product_grid/widgets/product_tile.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _productBloc = ProductBloc(GetIt.I<ProductsRepository>());

  @override
  void initState() {
    _productBloc.add(LoadProduct(categoryId: widget.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: TextButton(
              onPressed: () {
                AutoRouter.of(context)
                    .push(ProductAddScreen() as PageRouteInfo);
              },
              child: Text("Добавить товар")),
        ),
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
                    return ProductTile(product: productItem);
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