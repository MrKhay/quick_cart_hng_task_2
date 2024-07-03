import 'package:flutter/material.dart';

import '../../features.dart';

/// Manages [Product] data
class ProductDataProvider extends InheritedWidget {
  ///
  const ProductDataProvider({
    super.key,
    required super.child,
    required this.products,
    required this.isLoading,
  });

  /// list of [Product]
  final List<Product> products;

  /// true when fetching data
  final bool isLoading;

  ///
  static ProductDataProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductDataProvider>();
  }

  ///
  static ProductDataProvider of(BuildContext context) {
    final ProductDataProvider? result = maybeOf(context);
    assert(result != null, 'No ProductData found');
    return result!;
  }

  @override
  bool updateShouldNotify(ProductDataProvider oldWidget) {
    return oldWidget.isLoading != isLoading || oldWidget.products != products;
  }
}
