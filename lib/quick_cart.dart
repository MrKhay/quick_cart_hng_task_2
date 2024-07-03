import 'dart:async';

import 'package:flutter/material.dart';
import 'features/checkout/presentation/screens/checkout_screen.dart';
import 'features/features.dart';

///
class QuickCart extends StatefulWidget {
  ///
  const QuickCart({super.key});

  @override
  QuickCartState createState() => QuickCartState();
}

///
class QuickCartState extends State<QuickCart> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: BorderDirectional(
            top: BorderSide(
              color: context.colorScheme.outline,
              width: 0.11,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
            width: 0.05,
            color: context.colorScheme.outline,
          ))),
          child: NavigationBar(
            selectedIndex: _selectedIndex,

            onDestinationSelected: (int index) {
              setState(() {
                /// updated index
                _selectedIndex = index;
              });
            },

            // enableFloatingNavBar: false(
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.shopping_basket),
                label: kProducts,
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_rounded),
                label: kCheckout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<StatefulWidget> _screens = <StatefulWidget>[
  ProductsScreen(),
  CheckoutScreen(),
];
