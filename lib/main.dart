import 'dart:async';

import 'package:flutter/material.dart';

import 'features/features.dart';
import 'quick_cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// true when products are been fetched
  bool _isLoadingProducts = true;
  List<Product> _products = <Product>[];
  List<Order> _orders = <Order>[];
  final ProdcutsRepostiory _prodcutsRepostiory = const ProdcutsRepostiory();

  // load products
  void _loadProduct() {
    unawaited(_prodcutsRepostiory.getProducts().then(
      (List<Product> value) {
        setState(() {
          _isLoadingProducts = false;
          _products = value;
        });
      },
    ));
  }

  /// add new order
  void _addNewOrder(Order order) {
    setState(() {
      _orders = <Order>[order, ..._orders];
    });
  }

  /// remove  order
  void _removeNewOrder(Order order) {
    setState(() {
      _orders = _orders.where((Order o) => o != order).toList();
    });
  }

  /// modify order quantity
  void _modifyOrderQuantity(int quantity, String id) {
    setState(() {
      // update order
      _orders = _orders.map((Order order) {
        if (order.id == id) {
          return Order(
            id: id,
            product: order.product,
            quantity: quantity,
            time: order.time,
          );
        }
        return order;
      }).toList();
    });
  }

  /// modify order quantity
  void _clearOrders() {
    setState(() {
      // update order
      _orders = <Order>[];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    return OrderDataProvider(
      orders: _orders,
      addOrder: _addNewOrder,
      removeOrder: _removeNewOrder,
      modifyOrderQuantity: _modifyOrderQuantity,
      clearOrders: _clearOrders,
      child: ProductDataProvider(
        isLoading: _isLoadingProducts,
        products: _products,
        child: MaterialApp(
          title: kAppName,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
            useMaterial3: true,
          ),
          home: const QuickCart(),
        ),
      ),
    );
  }
}
