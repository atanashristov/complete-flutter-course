import 'package:flutter/foundation.dart';

import 'package:tony_ecommerce_app/src/localization/string_hardcoded.dart';

/// Order status
enum OrderStatus { confirmed, shipped, delivered }

/// Helper method to get the order status from String
extension OrderStatusString on OrderStatus {
  static OrderStatus fromString(String string) {
    if (string == 'confirmed') return OrderStatus.confirmed;
    if (string == 'shipped') return OrderStatus.shipped;
    if (string == 'delivered') return OrderStatus.delivered;
    throw Exception('Could not parse order status: $string'.hardcoded);
  }
}

/// * The order identifier is an important concept and can have its own type.
typedef OrderID = String;

/// Model class representing an order placed by the user.
class Order {
  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.orderStatus,
    required this.orderDate,
    required this.total,
  });

  /// Unique order ID
  final OrderID id;

  /// ID of the user who made the order
  final String userId;

  /// List of items in that order
  final Map<String, int> items;
  final OrderStatus orderStatus;
  final DateTime orderDate;
  final double total;

  @override
  String toString() {
    return 'Order(id: $id, userId: $userId, items: $items, orderStatus: $orderStatus, orderDate: $orderDate, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.userId == userId &&
        mapEquals(other.items, items) &&
        other.orderStatus == orderStatus &&
        other.orderDate == orderDate &&
        other.total == total;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ items.hashCode ^ orderStatus.hashCode ^ orderDate.hashCode ^ total.hashCode;
  }
}
