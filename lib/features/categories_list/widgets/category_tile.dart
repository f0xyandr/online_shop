import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/categories_list/bloc/product_categories_bloc.dart';
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

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          debugPrint("Category id ${category.categoryId}");
          AutoRouter.of(context)
              .push(ProductRoute(categoryId: category.categoryId));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: theme.primaryColor.withOpacity(0.2),
                child: Icon(
                  Icons.category,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.categoryName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${category.categoryId}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: theme.hintColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
