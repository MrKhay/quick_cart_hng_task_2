import 'package:flutter/material.dart';
import '../../features.dart';

/// Manages [Order] data
class OrderDataProvider extends InheritedWidget {
  ///
  const OrderDataProvider({
    super.key,
    required super.child,
    required this.orders,
    required this.addOrder,
    required this.removeOrder,
    required this.modifyOrderQuantity,
    required this.clearOrders,
  });

  /// list of [Order]
  final List<Order> orders;

  /// add new order
  final void Function(Order order) addOrder;

  /// remove order
  final void Function(Order order) removeOrder;

  /// remove order
  final void Function(int quantity, String orderId) modifyOrderQuantity;

  /// remove order
  final void Function() clearOrders;

  ///
  static OrderDataProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OrderDataProvider>();
  }

  ///
  static OrderDataProvider of(BuildContext context) {
    final OrderDataProvider? result = maybeOf(context);
    assert(result != null, 'No Order Data found');
    return result!;
  }

  @override
  bool updateShouldNotify(OrderDataProvider oldWidget) {
    return oldWidget.orders != orders;
  }
}
