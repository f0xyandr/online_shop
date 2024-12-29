import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../repositories/products/models/models.dart';
import '../../../repositories/products/products_repository.dart';
import '../bloc/checkout_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartItem> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  double calculateTotal() {
    return cartItems.fold(
        0, (sum, item) => sum + item.product.price * item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    final total = calculateTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Чек"),
      ),
      body: BlocProvider(
        create: (context) =>
            CheckoutBloc(repository: GetIt.I<ProductsRepository>()),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is TokenLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is TokenLoadingFailure) {
              debugPrint("Ошибка: ${state.e} \n${state.st}");
              return Center(
                child: Text('Ошибка: ${state.e} \n${state.st}'),
              );
            }

            return Column(
              children: [
                // Список товаров
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text(
                            "Цена: ${item.product.price} × ${item.quantity}"),
                        trailing: Text(
                            "Подитог: ${(item.product.price * item.quantity).toStringAsFixed(2)}"),
                      );
                    },
                  ),
                ),
                // Итоговая сумма
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Итого:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        total.toStringAsFixed(2),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // Кнопка подтверждения
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CheckoutBloc>(context)
                          .add(LoadPayment(cartItems));
                    },
                    child: const Text("Подтвердить покупку"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
