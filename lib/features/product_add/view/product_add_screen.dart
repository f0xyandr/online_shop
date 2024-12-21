import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../repositories/products/models/models.dart';

@RoutePage()
class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

final name = TextEditingController();
final price = TextEditingController();
final description = TextEditingController();

class _ProductAddScreenState extends State<ProductAddScreen> {
  List<ProductCategory> _categories = [];
  ProductCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await getProductCategoryList();
      setState(() {
        _categories = categories;
        if (categories.isNotEmpty) {
          _selectedCategory =
              categories.first; // Выбрать первый элемент по умолчанию
        }
      });
    } catch (e) {
      debugPrint("Ошибка загрузки категорий: $e");
    }
  }

  Future<List<ProductCategory>> getProductCategoryList() async {
    final listFromSupabase =
        await Supabase.instance.client.from("categories").select();
    List<ProductCategory> categoriesList = [];
    for (Map<String, dynamic> categoriesMap in listFromSupabase) {
      String name = categoriesMap['category_name'];
      int id = categoriesMap['category_id'];
      categoriesList.add(ProductCategory(categoryId: id, categoryName: name));
    }

    debugPrint("Полученные категории: $categoriesList");
    return categoriesList;
  }

  @override
  Widget build(BuildContext context) {
    var categoryList = [];
    final Future<List<ProductCategory>> _future = getProductCategoryList();
    return Scaffold(
      body: FutureBuilder(
          future: _future,
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductCategory>> snapshot) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: name,
                  ),
                  TextField(
                    controller: price,
                  ),
                  TextField(
                    controller: description,
                  ),
                  DropdownButton<ProductCategory>(
                    value: _selectedCategory,
                    items: _categories
                        .map((category) => DropdownMenuItem<ProductCategory>(
                              value: category,
                              child: Text(category.categoryName),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                      debugPrint("Выбранная категория: ${value?.categoryName}");
                    },
                  ),
                  TextButton(
                      onPressed: () async {
                        categoryList = await getProductCategoryList();
                        await Supabase.instance.client.from('products').insert({
                          'name': name.text,
                          'price': int.parse(price.text),
                          'user': await Supabase
                              .instance.client.auth.currentUser!.id,
                          'description': description.text,
                          'category_id': _selectedCategory!.categoryId,
                          'created_at': DateTime.now().toString()
                        });
                      },
                      child: Text("data"))
                ],
              ),
            );
          }),
    );
  }
}

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
