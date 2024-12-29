import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/categories_list/bloc/product_categories_bloc.dart';
import 'package:crypto_coins_list/repositories/products/models/product_category.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';

class InkWellChild extends StatelessWidget {
  const InkWellChild({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
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
                  name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: theme.hintColor,
          ),
        ],
      ),
    );
  }
}
