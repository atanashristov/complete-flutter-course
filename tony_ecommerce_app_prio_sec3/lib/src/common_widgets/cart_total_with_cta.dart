import 'package:flutter/material.dart';
import 'package:tony_ecommerce_app/src/common_widgets/cart_total_text.dart';
import 'package:tony_ecommerce_app/src/constants/app_sizes.dart';

/// Widget for showing the shopping cart total with a checkout button
class CartTotalWithCTA extends StatelessWidget {
  const CartTotalWithCTA({Key? key, required this.ctaBuilder}) : super(key: key);
  final WidgetBuilder ctaBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CartTotalText(),
        gapH8,
        ctaBuilder(context),
        gapH8,
      ],
    );
  }
}
