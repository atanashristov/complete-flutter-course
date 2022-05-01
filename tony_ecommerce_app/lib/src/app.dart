import 'package:go_router/go_router.dart';
import 'package:tony_ecommerce_app/src/features/products_list/products_list_screen.dart';
import 'package:tony_ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter(
      initialLocation: '/', // This is by default, but we also may configure whatever we want.
      debugLogDiagnostics: true, // All navigation events will be logged to log console.
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ProductsListScreen(),
        ),
      ],
    );
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'My Shop'.hardcoded,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.black, // background (button) color
            onPrimary: Colors.white, // foreground (text) color
          ),
        ),
      ),
    );
  }
}
