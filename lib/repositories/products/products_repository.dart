import 'package:crypto_coins_list/repositories/products/abstract_products_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/models.dart';

class ProductsRepository implements AbstractProductsRepository {
  final SupabaseClient supabase;

  ProductsRepository({required this.supabase});

  @override
  Future<List<CartItem>> getCartList() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    final response = await Supabase.instance.client
        .from("cart")
        .select("items")
        .eq("user", userId)
        .maybeSingle();
    List<CartItem> cartList = [];
    if (response != null) {
      final items = response['items'];
      final cartEntries = Map<String, int>.from(items).entries;
      for (var item in cartEntries) {
        var newProduct = await getProduct(int.parse(item.key));
        cartList.add(CartItem(product: newProduct, quantity: item.value));
      }
    }
    return cartList;
  }

  @override
  Future<List<Product>> getProductList(categoryId) async {
    final listFromSupabase = await Supabase.instance.client
        .from("products")
        .select()
        .eq('category_id', categoryId);
    List<Product> productList = [];
    for (Map<String, dynamic> productMap in listFromSupabase) {
      String name = productMap['name'];
      int price = productMap['price'];
      int id = productMap['product_id'];

      productList.add(Product(name: name, price: price, id: id));
    }
    return productList;
  }

  @override
  Future<Product> getProduct(productId) async {
    final product = await Supabase.instance.client
        .from("products")
        .select()
        .eq("product_id", productId)
        .maybeSingle();
    return Product(
        name: product!['name'], price: product['price'], id: product['id']);
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
