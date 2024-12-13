import 'models/models.dart';

abstract class AbstractProductsRepository {
  Future<List<Product>> getProductList(categoryId);
  Future<void> getProductCard(productId);
  Future<List<ProductCategory>> getProductCategoryList();
}
