import 'package:flutter/foundation.dart';

import 'package:tony_ecommerce_app/src/features/cart/domain/item.dart';
import 'package:tony_ecommerce_app/src/features/products/domain/product.dart';

/// Model class representing the shopping cart contents.
class Cart {
  const Cart([this.items = const {}]);

  /// All the items in the shopping cart, where:
  /// - key: product ID
  /// - value: quantity
  final Map<ProductID, int> items;

  @override
  String toString() => 'Cart(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart && mapEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

extension CartItems on Cart {
  List<Item> toItemsList() {
    return items.entries.map((entry) {
      return Item(
        productId: entry.key,
        quantity: entry.value,
      );
    }).toList();
  }
}
