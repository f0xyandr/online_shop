import 'package:collection/collection.dart';
import 'package:crypto_coins_list/repositories/products/abstract_products_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/models.dart';

class ProductsRepository implements AbstractProductsRepository {
  final SupabaseClient supabase;

  ProductsRepository({required this.supabase});

  @override
  Future<List<CartItem>> getCartList() async {
    try {
      final userId = await Supabase.instance.client.auth.currentUser!.id;

      // Получаем все товары в корзине текущего пользователя
      final response = await Supabase.instance.client
          .from('cart')
          .select('product_id')
          .eq('user', userId);

      if (response == null || response.isEmpty) {
        debugPrint("Корзина пуста.");
        return [];
      }

      // Подсчитываем количество каждого товара
      final Map<String, int> productCounts = {};
      for (var item in response) {
        final productId = item['product_id'].toString();
        productCounts[productId] = (productCounts[productId] ?? 0) + 1;
      }

      // Получаем данные о продуктах из таблицы products
      final productIds = productCounts.keys.toList();
      final productsResponse = await Supabase.instance.client
          .from('products')
          .select()
          .filter('product_id', 'in', '(${productIds.join(",")})');

      debugPrint("!!!!!!! $productsResponse");

      // Преобразуем в Map для быстрого доступа
      final productsMap = {
        for (var p in productsResponse) p['product_id'].toString(): p
      };

      debugPrint("1111111111 $productsMap");

      // Создаем список CartItem
      final List<CartItem> cartItems = productCounts.entries.map((entry) {
        final productData = productsMap[entry.key];
        debugPrint("^^^^^^^${productsMap[entry.key]}");
        final product = Product(
          id: productData!['product_id'],
          name: productData['name'],
          price: productData['price'],
        );
        return CartItem(product: product, quantity: entry.value);
      }).toList();

      debugPrint("!!!!!!! $cartItems");

      return cartItems;
    } catch (e, st) {
      debugPrint("Ошибка при получении корзины: $e, \n $st");
      return [];
    }
  }

  @override
  Future<List<Product>> getProductList(categoryId) async {
    final productResponse =
        await Supabase.instance.client.from("products").select("product_id");

    debugPrint("KSFKSMFKMFMKFM ${productResponse}");
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
    debugPrint("$product");
    return Product(
        name: product!['name'],
        price: product['price'],
        id: product['product_id']);
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
