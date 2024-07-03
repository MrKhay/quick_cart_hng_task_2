import 'package:flutter/material.dart';
import '../../../features.dart';
import 'order_success_screen.dart';

///
class CheckoutScreen extends StatefulWidget {
  /// Shows all orders
  const CheckoutScreen({super.key});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

///
class CheckoutScreenState extends State<CheckoutScreen> {
  List<Order> _orders = <Order>[];

  @override
  void didChangeDependencies() {
    _orders = OrderDataProvider.of(context).orders;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CheckoutScreen oldWidget) {
    _orders = OrderDataProvider.of(context).orders;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: kMyCart),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: kGap_3, vertical: kGap_3),
        child: _body(_orders),
      ),
    );
  }

  Widget _body(List<Order> orders) {
    final double height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        // body
        Expanded(
          child: SizedBox(
            height: height * 0.7,
            child: orders.isEmpty
                ? _emptyOrder()
                : Scrollbar(
                    child: ListView.separated(
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Order order = orders[index];
                        return orderCard(context, order);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: kGap_1),
                    ),
                  ),
          ),
        ),

        const SizedBox(height: kGap_2),
        // footer
        _checkOutBtn(_orders),
      ],
    );
  }

  Widget _emptyOrder() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.shopping_bag_sharp,
            color: context.colorScheme.outline,
          ),
          const SizedBox(height: kGap_1),
          Text(
            kEmptyCart,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkOutBtn(List<Order> orders) {
    final NavigatorState navigator = Navigator.of(context);

    // sum up price of all products
    final double totalPrice = orders.isEmpty
        ? 0
        : orders
            .map((Order order) => order.product.price * order.quantity)
            .reduce((double total, double price) => total + price);
    final String price = r'$' + totalPrice.toStringAsFixed(2);
    return Hero(
      tag: kOrderSucessTag,
      child: MaterialButton(
        color: context.colorScheme.primary,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(kGap_2)),
        minWidth: double.infinity,
        padding: const EdgeInsets.all(kGap_2),
        child: Text(
          '$kCheckout $price',
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          if (orders.isEmpty) {
            context.showSnackBar(kCartIsEmpty, type: SnackBarType.error);
            return;
          }

          /// naviagte to order success screen
          navigator.push(MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => OrderSuccessScreen(
              numOfProductOrder: orders.length,
              totalPrice: totalPrice,
            ),
          ));
        },
      ),
    );
  }
}

///
Widget orderCard(BuildContext context, Order order) {
  final double width = MediaQuery.of(context).size.width;
  final double totalPrice = order.product.price * order.quantity;
  return Container(
    height: double.infinity,
    width: width,
    constraints: BoxConstraints(
      minWidth: width,
      maxWidth: width,
      minHeight: width * 0.25,
      maxHeight: width * 0.3,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // img
        Flexible(
          flex: 2,
          child: Container(
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(kGap_2),
              image: DecorationImage(
                image: NetworkImage(
                  order.product.imgUrl,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(width: kGap_2),
        // details
        Flexible(
          flex: 3,
          child: SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(kGap_1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      order.product.name,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: kGap_1),

                  /// Price
                  Flexible(
                    child: Text(
                      r'$' + totalPrice.toStringAsFixed(2),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: kGap_1),
                  // Quantity
                  Flexible(
                    child: CounterWidget(
                      initalValue: order.quantity,
                      onCountChange: (int quantity) {
                        ///
                        OrderDataProvider.of(context)
                            .modifyOrderQuantity(quantity, order.id);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        /// remove btn
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kGap_2),
          ),
          child: IconButton(
              onPressed: () async {
                final bool? responce = await showConfirmationDialog(
                  context,
                  titleText: kRemoveOrderFromCartInfo,
                  actionTxtColor: context.colorScheme.onPrimary,
                  actionBtnColor: context.colorScheme.primary,
                );
                if (responce == null) return;

                // when accepted
                if (responce) {
                  OrderDataProvider.of(context).removeOrder(order);
                  context.showSnackBar(kOrderRemoved,
                      type: SnackBarType.success);
                }
              },
              icon: Icon(
                Icons.delete,
                color: context.colorScheme.error,
              )),
        ),
      ],
    ),
  );
}
