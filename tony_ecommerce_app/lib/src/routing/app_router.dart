import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tony_ecommerce_app/src/features/products_list/products_list_screen.dart';
import 'package:tony_ecommerce_app/src/features/shopping_cart/shopping_cart_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/', // This is by default, but we also may configure whatever we want.
  debugLogDiagnostics: true, // All navigation events will be logged to log console.
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'cart',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true, // Controls the animation from the bottom instead from the right side.
            child: const ShoppingCartScreen(),
          ),
        ),
      ],
    ),
  ],
);
