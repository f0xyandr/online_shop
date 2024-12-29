import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/categories_list/view/product_categories_screen.dart';
import 'package:crypto_coins_list/features/home/bloc/home_bloc.dart';
import 'package:crypto_coins_list/features/product_grid/widgets/product_tile.dart';
import 'package:crypto_coins_list/features/profile/profile.dart';
import 'package:crypto_coins_list/repositories/products/products_repository.dart';
import 'package:crypto_coins_list/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../cart/view/view.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();

    _homeBloc = HomeBloc(GetIt.I<ProductsRepository>())
      ..add(LoadHomeProducts());

    _screens = [
      _buildHomeContent(),
      const ProductCategoriesScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onChanged: (query) {
              // Handle search logic
            },
          ),
        ),
        Expanded(
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            bloc: _homeBloc,
            builder: (context, state) {
              if (state is HomeLoaded) {
                final products = state.randomProducts;
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductTile(product: product);
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
