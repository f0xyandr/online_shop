import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/repositories/products/models/product.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListTile(
        tileColor: Colors.grey,
        title: Text(
          product.name,
          style: theme.textTheme.bodyMedium,
        ),
        subtitle: (Text(
          '${product.price} \$',
          style: theme.textTheme.labelSmall,
        )),
        trailing: const Icon(Icons.arrow_forward_ios),
        // onTap: () {
        //   AutoRouter.of(context).push(ProductRoute(cryptoCoin: coin));
        // },
      ),
    );
  }
}
