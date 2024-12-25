// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthScreen();
    },
  );
}

/// generated route for
/// [CartScreen]
class CartRoute extends PageRouteInfo<CartRouteArgs> {
  CartRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CartRoute.name,
          args: CartRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<CartRouteArgs>(orElse: () => const CartRouteArgs());
      return CartScreen(key: args.key);
    },
  );
}

class CartRouteArgs {
  const CartRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'CartRouteArgs{key: $key}';
  }
}

/// generated route for
/// [CryptoCoinScreen]
class CryptoCoinRoute extends PageRouteInfo<CryptoCoinRouteArgs> {
  CryptoCoinRoute({
    Key? key,
    required CryptoCoin cryptoCoin,
    List<PageRouteInfo>? children,
  }) : super(
          CryptoCoinRoute.name,
          args: CryptoCoinRouteArgs(
            key: key,
            cryptoCoin: cryptoCoin,
          ),
          initialChildren: children,
        );

  static const String name = 'CryptoCoinRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CryptoCoinRouteArgs>();
      return CryptoCoinScreen(
        key: args.key,
        cryptoCoin: args.cryptoCoin,
      );
    },
  );
}

class CryptoCoinRouteArgs {
  const CryptoCoinRouteArgs({
    this.key,
    required this.cryptoCoin,
  });

  final Key? key;

  final CryptoCoin cryptoCoin;

  @override
  String toString() {
    return 'CryptoCoinRouteArgs{key: $key, cryptoCoin: $cryptoCoin}';
  }
}

/// generated route for
/// [CryptoListScreen]
class CryptoListRoute extends PageRouteInfo<void> {
  const CryptoListRoute({List<PageRouteInfo>? children})
      : super(
          CryptoListRoute.name,
          initialChildren: children,
        );

  static const String name = 'CryptoListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CryptoListScreen();
    },
  );
}

/// generated route for
/// [ProductAddScreen]
class ProductAddRoute extends PageRouteInfo<void> {
  const ProductAddRoute({List<PageRouteInfo>? children})
      : super(
          ProductAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductAddRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProductAddScreen();
    },
  );
}

/// generated route for
/// [ProductCardScreen]
class ProductCardRoute extends PageRouteInfo<ProductCardRouteArgs> {
  ProductCardRoute({
    Key? key,
    required Product product,
    List<PageRouteInfo>? children,
  }) : super(
          ProductCardRoute.name,
          args: ProductCardRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductCardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductCardRouteArgs>();
      return ProductCardScreen(
        key: args.key,
        product: args.product,
      );
    },
  );
}

class ProductCardRouteArgs {
  const ProductCardRouteArgs({
    this.key,
    required this.product,
  });

  final Key? key;

  final Product product;

  @override
  String toString() {
    return 'ProductCardRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [ProductCategoriesScreen]
class ProductCategoriesRoute extends PageRouteInfo<void> {
  const ProductCategoriesRoute({List<PageRouteInfo>? children})
      : super(
          ProductCategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductCategoriesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProductCategoriesScreen();
    },
  );
}

/// generated route for
/// [ProductDeleteScreen]
class ProductDeleteRoute extends PageRouteInfo<void> {
  const ProductDeleteRoute({List<PageRouteInfo>? children})
      : super(
          ProductDeleteRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductDeleteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProductDeleteScreen();
    },
  );
}

/// generated route for
/// [ProductScreen]
class ProductRoute extends PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    Key? key,
    required int categoryId,
    List<PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(
            key: key,
            categoryId: categoryId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductRouteArgs>();
      return ProductScreen(
        key: args.key,
        categoryId: args.categoryId,
      );
    },
  );
}

class ProductRouteArgs {
  const ProductRouteArgs({
    this.key,
    required this.categoryId,
  });

  final Key? key;

  final int categoryId;

  @override
  String toString() {
    return 'ProductRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [RegistrationScreen]
class RegistrationRoute extends PageRouteInfo<void> {
  const RegistrationRoute({List<PageRouteInfo>? children})
      : super(
          RegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegistrationScreen();
    },
  );
}

class CheckoutRoute extends PageRouteInfo<CheckoutRouteArgs> {
  CheckoutRoute({
    Key? key,
    required List<CartItem> cartItems,
    List<PageRouteInfo>? children,
  }) : super(
          CheckoutRoute.name,
          args: CheckoutRouteArgs(
            key: key,
            cartItems: cartItems,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CheckoutRouteArgs>();
      return CheckoutScreen(
        cartItems: args.cartItems,
      );
    },
  );
}

class CheckoutRouteArgs {
  const CheckoutRouteArgs({
    this.key,
    required this.cartItems,
  });

  final Key? key;

  final List<CartItem> cartItems;

  @override
  String toString() {
    return 'ProductCardRouteArgs{key: $key, product: $cartItems}';
  }
}

class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}
