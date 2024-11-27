import 'package:crypto_coins_list/repositories/products/models/product.dart';
import 'package:crypto_coins_list/repositories/products/abstract_products_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsRepository implements AbstractProductsRepository {
  final Supabase supabase;

  ProductsRepository({required this.supabase});
  @override
  Future<List<Product>> getProductList() async {
    final listFromSupabase =
        await Supabase.instance.client.from("products").select();
    List<Product> productList = [];
    for (Map<String, dynamic> productMap in listFromSupabase) {
      String name = productMap['name'];
      int price = productMap['price'];
      int id = productMap['id'];
      productList.add(Product(name: name, price: price, id: id));
    }

    debugPrint("$listFromSupabase");
    debugPrint("$productList");
    return productList;
  }
}
