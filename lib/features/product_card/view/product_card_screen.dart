import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/product_card/bloc/product_card_bloc.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:crypto_coins_list/features/cart/cart.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_coins_list/repositories/products/models/models.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class ProductCardScreen extends StatefulWidget {
  const ProductCardScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductCardScreen> createState() => _ProductCardScreenState();
}

class _ProductCardScreenState extends State<ProductCardScreen> {
  final _productCardBloc = ProductCardBloc(GetIt.I<ProductsRepository>());

  @override
  void initState() {
    _productCardBloc.add(LoadProductCard(widget.product));
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
        title: Text(widget.product.name),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCardBloc, ProductCardState>(
        bloc: _productCardBloc,
        builder: (context, state) {
          if (state is ProductCardLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                            state.product.imageUrl ??
                                'https://prgbgbhgwpzlvtfvggsj.supabase.co/storage/v1/object/public/images/morioh.jpg', // Заглушка, если нет изображения
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Product Name
                    Text(
                      state.product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Product Price
                    Row(
                      children: [
                        if (state.product.discount != null) ...[
                          Text(
                            '\$${widget.product.priceWithDiscount().toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '\$${state.product.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ] else
                          Text(
                            '\$${state.product.price}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Product Description
                    const SizedBox(height: 8),

                    state.product.specification != null
                        ? state.product.specification!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Характеристики:",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...state.product.specification!.entries.map(
                                    (entry) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${entry.key}: ",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${entry.value}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const Text(
                                "Характеристики отсутствуют.",
                                style: TextStyle(fontSize: 16),
                              )
                        : const Text(
                            "Характеристики отсутствуют.",
                            style: TextStyle(fontSize: 16),
                          ),

                    // Add to Cart Button
                    ElevatedButton(
                      onPressed: () async {
                        final userId =
                            Supabase.instance.client.auth.currentUser?.id;

                        if (userId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Необходимо авторизоваться.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        try {
                          await Supabase.instance.client.from('cart').insert({
                            'user': userId,
                            'product_id': state.product.id,
                          });
                          debugPrint("Товар добавлен в корзину.");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Товар добавлен в корзину!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          debugPrint("Ошибка при добавлении товара: $e");
                        }
                      },
                      child: const Text("Добавить в корзину"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Navigate to Cart Button
                    TextButton(
                      onPressed: () {
                        AutoRouter.of(context).push(CartRoute());
                      },
                      child: const Text("Перейти в корзину"),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
