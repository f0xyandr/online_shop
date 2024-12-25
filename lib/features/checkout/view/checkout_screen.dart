import 'package:flutter/material.dart';

import '../../../repositories/products/models/models.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartItem> cartItems;

  CheckoutScreen({required this.cartItems});

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
      body: Column(
        children: [
          // Список товаров
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.product.name),
                  subtitle:
                      Text("Цена: ${item.product.price} × ${item.quantity}"),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${total.toStringAsFixed(2)}",
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
                // Логика оформления заказа
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Заказ оформлен!")),
                );
              },
              child: const Text("Подтвердить покупку"),
            ),
          ),
        ],
      ),
    );
  }
}
