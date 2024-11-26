import 'package:crypto_coins_list/repositories/crypto_coins/models/product.dart';
import 'package:crypto_coins_list/repositories/products/abstract_products_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsRepository implements AbstractProductsRepository {
  final Supabase supabase;

  ProductsRepository({required this.supabase});
  @override
  Future<List<Product>> getProductList() async {
    List<Product> productList = [];
    final listFromSupabase =
        await Supabase.instance.client.from("products").select();
    listFromSupabase.map((e) {
      int id = e['id'];
      String name = e['name'];
      int price = e['price'];
      // String created_at = e['created_at'];
      productList.add(Product(name: name, price: price, id: id));
    });
    return productList;
  }
}
