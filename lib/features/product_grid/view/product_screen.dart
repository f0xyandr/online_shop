import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/product_add/product_add.dart';
import 'package:crypto_coins_list/features/product_grid/bloc/product_bloc.dart';
import 'package:crypto_coins_list/features/product_grid/widgets/product_tile.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:crypto_coins_list/router/router.dart';
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

  final _minValue = TextEditingController();
  final _maxValue = TextEditingController();

  @override
  void initState() {
    _productBloc.add(LoadProduct(categoryId: widget.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              AutoRouter.of(context).maybePop();
            },
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Заголовок диалога'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              TextFormField(
                                controller: _minValue,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              TextFormField(
                                controller: _maxValue,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _productBloc.add(LoadFilteredProduct(
                                        minPrice: double.parse(_minValue.text),
                                        maxPrice:
                                            double.parse(_maxValue.text)));
                                  });
                                },
                                child: Text(""),
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Закрыть'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Закрывает диалог
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("data"))
          ],
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
