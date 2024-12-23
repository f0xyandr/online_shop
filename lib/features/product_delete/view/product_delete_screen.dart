import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../repositories/products/models/models.dart';

@RoutePage()
class ProductDeleteScreen extends StatefulWidget {
  const ProductDeleteScreen({super.key});

  @override
  State<ProductDeleteScreen> createState() => _ProductDeleteScreenState();
}

final name = TextEditingController();
final price = TextEditingController();
final description = TextEditingController();

class _ProductDeleteScreenState extends State<ProductDeleteScreen> {
  List<Product> _products = [];
  Product? _selectedProduct;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await getProductList();
      setState(() {
        _products = products;
        if (products.isNotEmpty) {
          _selectedProduct =
              products.first; // Выбрать первый элемент по умолчанию
        }
      });
      debugPrint("$products");
    } catch (e) {
      debugPrint("Ошибка загрузки категорий: $e");
    }
  }

  @override
  Future<List<Product>> getProductList() async {
    final listFromSupabase = await Supabase.instance.client
        .from("products")
        .select()
        .eq('user', await Supabase.instance.client.auth.currentUser!.id);
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
  Widget build(BuildContext context) {
    var categoryList = [];

    return Scaffold(
        body: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<Product>(
              value: _selectedProduct,
              items: _products
                  .map((product) => DropdownMenuItem<Product>(
                        value: product,
                        child: Text(product.name),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProduct = value;
                });
                debugPrint("Выбранная категория: ${value?.name}");
              },
            ),
            TextButton(
                onPressed: () async {
                  Supabase.instance.client.auth.currentUser!.id is! Null &&
                          _products.isNotEmpty
                      ? await Supabase.instance.client
                          .from('products')
                          .delete()
                          .eq('product_id', _selectedProduct!.id)
                      : debugPrint("Не удалось удалить товар");
                },
                child: Text("Удалить"))
          ],
        ),
      ),
    ));
  }
}
