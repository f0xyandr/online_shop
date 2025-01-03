import 'package:crypto_coins_list/repositories/products/models/cart_item.dart';

import 'models/models.dart';

abstract class AbstractProductsRepository {
  Future<List<Product>> getProductList(categoryId);
  Future<Product> getProduct(productId);
  Future<List<ProductCategory>> getProductCategoryList();
  Future<List<CartItem>> getCartList();
  Future<List<Product>> fetchRandomProducts();

  Future<String> getPayPalAccessToken({String clientId, String secret});
  Future<void> createTestPayment(String accessToken, double amount);
}
