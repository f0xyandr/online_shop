import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/categories_list/widgets/category_tile.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/product_categories_bloc.dart';

@RoutePage()
class ProductCategoriesScreen extends StatefulWidget {
  const ProductCategoriesScreen({super.key});

  @override
  State<ProductCategoriesScreen> createState() =>
      _ProductCategoriesScreenState();
}

class _ProductCategoriesScreenState extends State<ProductCategoriesScreen> {
  final _productCategoriesBloc =
      ProductCategoriesBloc(GetIt.I<ProductsRepository>());

  @override
  void initState() {
    _productCategoriesBloc.add(const LoadProductCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(50),
        //   child: AppBar(
        //     title: const Text('Product Categories'),
        //     centerTitle: true,
        //     backgroundColor: Colors.teal,
        //   ),
        // ),
        body: BlocBuilder<ProductCategoriesBloc, ProductCategoriesState>(
          bloc: _productCategoriesBloc,
          builder: (context, state) {
            if (state is ProductCategoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductCategoriesLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.transparent,
                  thickness: 0.1,
                  indent: 4,
                  endIndent: 4,
                ),
                itemCount: state.productCategoriesList.length,
                itemBuilder: (context, index) {
                  final categoryItem = state.productCategoriesList[index];
                  return ProductCategoryTile(category: categoryItem);
                },
              );
            }

            if (state is ProductCategoriesLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Failed to load categories',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _productCategoriesBloc
                            .add(const LoadProductCategories());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text('Unexpected state'));
          },
        ),
      ),
    );
  }
}
