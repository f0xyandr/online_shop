// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../repositories/products/models/models.dart';

@RoutePage()
class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _specKey = TextEditingController();
  final TextEditingController _specValue = TextEditingController();

  final Map<String, String> _specMap = {};

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
          _selectedCategory = categories.first;
        }
      });
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }
  }

  Future<List<ProductCategory>> getProductCategoryList() async {
    final listFromSupabase =
        await Supabase.instance.client.from("categories").select();
    return listFromSupabase.map<ProductCategory>((categoriesMap) {
      return ProductCategory(
        categoryId: categoriesMap['category_id'],
        categoryName: categoriesMap['category_name'],
      );
    }).toList();
  }

  Future<void> _addProduct() async {
    if (_priceController.text.isEmpty || _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please fill all fields and select a category.')),
      );

      return;
    }
    if (int.parse(_discountController.text) > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Discount can\'t be greater than 99%')),
      );
      return;
    }

    try {
      await Supabase.instance.client.from('products').insert({
        'name': _nameController.text,
        'price': int.parse(_priceController.text),
        'user': Supabase.instance.client.auth.currentUser!.id,
        'description': _descriptionController.text,
        'discount_percent': int.parse(
            _discountController.text.isEmpty ? '0' : _discountController.text),
        'price_with_discount': (int.parse(_priceController.text) -
            (int.parse(_priceController.text) *
                int.parse(_discountController.text.isEmpty
                    ? '0'
                    : _discountController.text) /
                100)),
        'category_id': _selectedCategory!.categoryId,
        'created_at': DateTime.now().toIso8601String(),
        'specification': _specMap
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added successfully!')),
      );
      _clearForm();
    } catch (e) {
      debugPrint("Error adding product: $e");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product.')),
      );
    }
  }

  void _clearForm() {
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _discountController.clear();
    setState(() {
      _selectedCategory = _categories.isNotEmpty ? _categories.first : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            AutoRouter.of(context).maybePop();
          },
        ),
      ),
      body: _categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _discountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Discount (%)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<ProductCategory>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.categoryName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Заголовок диалога'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _specKey,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _specValue,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _specMap?[_specKey.text] =
                                            _specValue.text;
                                        debugPrint("$_specMap");
                                      },
                                      child: Text(""),
                                    )
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Закрыть'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Закрывает диалог
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Показать диалог'),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: _addProduct,
                        child: Text('Add Product'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
