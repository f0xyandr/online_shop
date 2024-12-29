import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/repositories/products/models/product.dart';
import 'package:flutter/material.dart';

import '../../../router/router.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    if (product.discount is! int) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: InkWell(
          onTap: () {
            AutoRouter.of(context).push(ProductCardRoute(product: product));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                  child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Icon(
                  Icons.broken_image_outlined,
                  size: 40,
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).push(ProductCardRoute(product: product));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
                child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Icon(
                Icons.broken_image_outlined,
                size: 40,
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: const Color.fromARGB(255, 150, 0, 0),
                        decoration: TextDecoration.lineThrough),
                  ),
                  Text(
                    '\$${product.priceWithDiscount().toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
