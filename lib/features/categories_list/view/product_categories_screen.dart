import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/categories_list/widgets/category_tile.dart';
import 'package:crypto_coins_list/features/product_grid/bloc/product_bloc.dart';
import 'package:crypto_coins_list/features/product_grid/view/product_screen.dart';
import 'package:crypto_coins_list/features/product_grid/widgets/product_tile.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../bloc/product_categories_bloc.dart';

@RoutePage()
class ProductCategoriesScreen extends StatefulWidget {
  const ProductCategoriesScreen({super.key});

  @override
  State<ProductCategoriesScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductCategoriesScreen> {
  final _productCategoriesBloc =
      ProductCategoriesBloc(GetIt.I<ProductsRepository>());

  @override
  void initState() {
    _productCategoriesBloc.add(const LoadProductCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ProductCategoriesBloc, ProductCategoriesState>(
            bloc: _productCategoriesBloc,
            builder: (context, state) {
              if (state is ProductCategoriesLoaded) {
                return ListView.separated(
                  separatorBuilder: (context, state) => const Divider(
                    color: Colors.black,
                  ),
                  itemCount: state.productCategoriesList.length,
                  itemBuilder: ((context, index) {
                    final categoryItem = state.productCategoriesList[index];
                    debugPrint("${categoryItem.categoryId}");
                    return ProductCategoryTile(category: categoryItem);
                  }),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
