import 'package:crypto_coins_list/repositories/products/models/product.dart';
import 'package:crypto_coins_list/repositories/products/abstract_products_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/models.dart';

class ProductsRepository implements AbstractProductsRepository {
  final SupabaseClient supabase;

  ProductsRepository({required this.supabase});
  @override
  Future<List<Product>> getProductList(categoryId) async {
    final listFromSupabase = await Supabase.instance.client
        .from("products")
        .select()
        .eq('category_id', categoryId);
    debugPrint(" ######### $listFromSupabase");
    List<Product> productList = [];
    for (Map<String, dynamic> productMap in listFromSupabase) {
      String name = productMap['name'];
      int price = productMap['price'];
      int id = productMap['product_id'];

      productList.add(Product(name: name, price: price, id: id));
    }

    debugPrint(" @@@@@@@@ $listFromSupabase");
    debugPrint("******** $productList");
    return productList;
  }

  @override
  Future<void> getProductCard(productId) async {
    final product = await Supabase.instance.client
        .from("products")
        .select()
        .eq("product_id", productId);

    debugPrint("${productId}");
  }

  @override
  Future<List<ProductCategory>> getProductCategoryList() async {
    final listFromSupabase =
        await Supabase.instance.client.from("categories").select();
    List<ProductCategory> categoriesList = [];
    for (Map<String, dynamic> categoriesMap in listFromSupabase) {
      String name = categoriesMap['category_name'];
      int id = categoriesMap['category_id'];
      categoriesList.add(ProductCategory(categoryId: id, categoryName: name));
    }

    debugPrint("!!!!!!! $listFromSupabase");
    debugPrint("$categoriesList");

    return categoriesList;
  }
}
