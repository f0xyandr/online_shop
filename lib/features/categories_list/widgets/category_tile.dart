import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/categories_list/bloc/product_categories_bloc.dart';
import 'package:crypto_coins_list/repositories/products/models/product.dart';
import 'package:crypto_coins_list/repositories/products/models/product_category.dart';

import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';

class ProductCategoryTile extends StatelessWidget {
  const ProductCategoryTile({
    Key? key,
    required this.category,
  }) : super(key: key);

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListTile(
        tileColor: Colors.grey,
        title: Text(
          category.categoryName,
          style: theme.textTheme.bodyMedium,
        ),
        subtitle: (Text(
          '${category.categoryId} \$',
          style: theme.textTheme.labelSmall,
        )),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          debugPrint("Category id ${category.categoryId}");
          AutoRouter.of(context)
              .push(ProductRoute(categoryId: category.categoryId));
        },
      ),
    );
  }
}
