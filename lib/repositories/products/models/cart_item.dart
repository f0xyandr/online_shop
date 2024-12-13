import 'package:crypto_coins_list/repositories/products/models/product.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});
  final Product product;
  final int quantity;
}
