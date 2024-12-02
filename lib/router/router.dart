import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/auth/view/auth_screen.dart';
import 'package:crypto_coins_list/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_coins_list/features/crypto_list/crypto_list.dart';
import 'package:crypto_coins_list/features/product_grid/view/product_screen.dart';
import 'package:crypto_coins_list/features/registration/view/registration.dart';
import 'package:flutter/material.dart';

import '../repositories/crypto_coins/models/models.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CryptoListRoute.page, path: '/'),
        AutoRoute(page: CryptoCoinRoute.page, path: '/coin'),
        AutoRoute(page: ProductRoute.page, path: '/product'),
        AutoRoute(page: AuthRoute.page, path: '/auth'),
        AutoRoute(page: RegistrationRoute.page, path: '/reg'),
      ];
}

// final routes = {
//   '/': (context) => const CryptoListScreen(),
//   '/coin': (context) => const CryptoCoinScreen(),
// };
