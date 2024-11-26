import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final future = Supabase.instance.client.from('products').select();
    return Scaffold(
        body: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final products = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30),
                itemCount: products.length,
                itemBuilder: ((context, index) {
                  final productItem = products[index];
                  return ListTile(
                    title: Center(child: Text(productItem['name'])),
                    tileColor: Colors.white,
                  );
                }),
              );
            }));
  }
}
