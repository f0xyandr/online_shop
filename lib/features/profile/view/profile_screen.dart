import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/profile/widgets/profile_tile.dart';
import 'package:flutter/material.dart';

import '../../../router/router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          Card(
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).push(CartRoute());
              },
              child: InkWellChild(name: "To cart"),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).push(const ProductAddRoute());
              },
              child: InkWellChild(name: "Add"),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).push(const ProductDeleteRoute());
              },
              child: InkWellChild(name: "Delete"),
            ),
          ),
        ],
      ),
    );
  }
}
