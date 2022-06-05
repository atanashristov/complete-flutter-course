import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tony_ecommerce_app/src/features/account/account_screen.dart';
import 'package:tony_ecommerce_app/src/features/checkout/checkout_screen.dart';
import 'package:tony_ecommerce_app/src/features/leave_review_page/leave_review_screen.dart';
import 'package:tony_ecommerce_app/src/features/not_found/not_found_screen.dart';
import 'package:tony_ecommerce_app/src/features/orders_list/orders_list_screen.dart';
import 'package:tony_ecommerce_app/src/features/product_page/product_screen.dart';
import 'package:tony_ecommerce_app/src/features/products_list/products_list_screen.dart';
import 'package:tony_ecommerce_app/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:tony_ecommerce_app/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:tony_ecommerce_app/src/features/sign_in/email_password_sign_in_state.dart';

enum AppRoute {
  home,
  product,
  leaveReview,
  cart,
  checkout,
  orders,
  account,
  signIn,
}

final goRouter = GoRouter(
  initialLocation: '/', // This is by default, but we also may configure whatever we want.
  debugLogDiagnostics: true, // All navigation events will be logged to log console.
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'product/:id',
          name: AppRoute.product.name,
          builder: (context, state) {
            final productId = state.params['id']!;
            return ProductScreen(productId: productId);
          },
          routes: [
            GoRoute(
              path: 'review',
              name: AppRoute.leaveReview.name,
              pageBuilder: (context, state) {
                final productId = state.params['id']!;
                return MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true, // Controls the animation from the bottom instead from the right side.
                  child: LeaveReviewScreen(productId: productId),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'cart',
          name: AppRoute.cart.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true, // Controls the animation from the bottom instead from the right side.
            child: const ShoppingCartScreen(),
          ),
          routes: [
            GoRoute(
              path: 'checkout',
              name: AppRoute.checkout.name,
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true, // Controls the animation from the bottom instead from the right side.
                child: const CheckoutScreen(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'orders',
          name: AppRoute.orders.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true, // Controls the animation from the bottom instead from the right side.
            child: const OrdersListScreen(),
          ),
        ),
        GoRoute(
          path: 'account',
          name: AppRoute.account.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true, // Controls the animation from the bottom instead from the right side.
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          path: 'sign_in',
          name: AppRoute.signIn.name,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true, // Controls the animation from the bottom instead from the right side.
            child: const EmailPasswordSignInScreen(
              formType: EmailPasswordSignInFormType.signIn,
            ),
          ),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
