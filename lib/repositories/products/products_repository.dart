import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:crypto_coins_list/repositories/products/abstract_products_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/models.dart';

class ProductsRepository implements AbstractProductsRepository {
  ProductsRepository({required this.dio});

  Dio dio;

// Пример создания тестового платежа

  Future<String> getPayPalAccessToken(
      {String clientId =
          'AQzblLGRa8VdNITjCzpB9VxJsmtHGAgus126f8M-wYn5moPPXhu_ZMHY2bvHxInuVpda-RW-r_bvo7X5',
      String secret =
          'EKNYCxBYOQBjsd3Rm9qMJIBaC9wu0dhoU9xQN3AFThmhdhJP0ddw1i5haAvA5hsx7ZpQS16Y8BMHcZFY'}) async {
    final response = await dio.post(
      'https://api.sandbox.paypal.com/v1/oauth2/token',
      options: Options(
        headers: {
          'Authorization':
              'Basic ' + base64Encode(utf8.encode('$clientId:$secret')),
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      data: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      return response.data['access_token'];
    } else {
      throw Exception('Failed to get access token: ${response.data}');
    }
  }

  Future<void> createTestPayment(String accessToken, double amount) async {
    debugPrint("\n\n\n Access Token: $accessToken \n Amount: $amount\n\n\n");

    final data = {
      'intent': 'sale',
      'payer': {
        'payment_method': 'paypal',
      },
      'transactions': [
        {
          'amount': {
            'total': amount.toStringAsFixed(
                2), // Убедитесь, что это строка с двумя знаками после запятой

            'currency': 'USD',
          },
          'description': 'Тестовый платеж',
        },
      ],
      'redirect_urls': {
        'return_url': 'https://example.com/return',
        'cancel_url':
            'https://example.com/cancel', // Убедитесь, что это корректный URL
      },
    };

    debugPrint('Request data: ${jsonEncode(data)}'); // Логируйте данные запроса

    try {
      final response = await dio.post(
        'https://api.sandbox.paypal.com/v1/payments/payment',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        debugPrint('Payment created successfully: ${response.data}');
      } else {
        debugPrint('Failed to create payment: ${response.data}');
      }
    } catch (e) {
      if (e is DioError) {
        debugPrint(
            'Error creating payment: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        debugPrint('Unexpected error: $e');
      }
    }
  }

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

  Future<void> deleteCartItems(userId, List productIds) async {
    // Удаление записей из таблицы `cart`, где совпадают `user` и `product_id`
    await Supabase.instance.client
        .from('cart')
        .delete()
        .match({'user': userId}).filter(
            'product_id', 'in', '(${productIds.join(",")})');
    debugPrint("$userId");
    debugPrint("$productIds");
  }

  @override
  Future<List<Product>> fetchRandomProducts() async {
    try {
      final response = await Supabase.instance.client
          .rpc('random_products', params: {'limit_count': 10});

      if (response == null) {
        throw Exception('Failed to fetch products: Response is null.');
      }

      final data = response as List<dynamic>;

      debugPrint("$data");
      return data.map((item) {
        return Product(
          id: item['product_id'],
          name: item['name'],
          price: item['price'],
          discount: item['discount_percent'],
        );
      }).toList();
    } catch (e) {
      debugPrint("Error fetching products: $e");
      rethrow;
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
      int discount = productMap['discount_percent'];

      productList
          .add(Product(name: name, price: price, id: id, discount: discount));
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

    if (product == null) {
      throw Exception('Продукт с ID $productId не найден.');
    }

    return Product(
      name: product['name'],
      price: product['price'],
      id: product['product_id'],
      discount: product['discount_percent'],
      imageUrl: product['image_url'] ??
          "https://prgbgbhgwpzlvtfvggsj.supabase.co/storage/v1/object/public/images/morioh.jpg",
      description: product['description'],
      specification: product['specification'] != null
          ? Map<String, dynamic>.from(product['specification'])
          : null,
    );
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
