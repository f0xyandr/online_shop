import '../crypto_coins/models/models.dart';

abstract class AbstractProductsRepository {
  Future<List<Product>> getProductList();
}
