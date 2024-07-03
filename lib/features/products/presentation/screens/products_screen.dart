import 'package:flutter/material.dart';
import '../../../features.dart';

///
class ProductsScreen extends StatefulWidget {
  /// [Product] screen displays all products
  const ProductsScreen({super.key});

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

///
class ProductsScreenState extends State<ProductsScreen> {
  bool _isLoadingData = true;
  String _selectedCategory = 'All';
  List<Product> _products = <Product>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _isLoadingData = ProductDataProvider.of(context).isLoading;
    _products = ProductDataProvider.of(context).products;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ProductsScreen oldWidget) {
    _isLoadingData = ProductDataProvider.of(context).isLoading;
    _products = ProductDataProvider.of(context).products;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        title: kProduct,
        elevation: 0,
        backgroundColor: context.colorScheme.surface,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: kGap_3, right: kGap_3, top: kGap_2),
        child: _isLoadingData ? _loading() : _body(_products),
      ),
    );
  }

  Widget _loading() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: context.textTheme.titleLarge?.fontSize,
          height: context.textTheme.titleLarge?.fontSize,
          child: const CircularProgressIndicator.adaptive(),
        ),
        const SizedBox(height: kGap_2),
        Text(
          kFetchingProducts,
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.outline,
          ),
        ),
      ],
    ));
  }

  Widget _body(List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ///
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              kCategories,
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            // Text(
            //   kViewAllCategories,
            //   style: context.textTheme.bodySmall?.copyWith(
            //     fontWeight: FontWeight.bold,
            //     color: context.colorScheme.primary,
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: kGap_2),

        _catergoriesContainer(products.getCategories(), _selectedCategory),

        const SizedBox(height: kGap_2),

        ///
        Text(
          kItems,
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: kGap_2),

        ///
        Expanded(
            child: _productGrid(products.filterByCategory(_selectedCategory))),
      ],
    );
  }

  Widget _catergoriesContainer(
      List<String> categories, String selectedCategory) {
    return SizedBox(
      width: context.screenSize.width,
      height: context.screenSize.width * 0.13,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final String category = categories[index];
          final bool isSelected = category == selectedCategory;
          return GestureDetector(
            onTap: () {
              // update selected category
              setState(() {
                _selectedCategory = category;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              height: double.infinity,
              margin: const EdgeInsets.all(kGap_1),
              padding: const EdgeInsets.symmetric(
                  horizontal: kGap_2, vertical: kGap_1),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.colorScheme.inverseSurface
                    : context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(kGap_0),
              ),
              child: Text(
                category,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : null,
                  color: isSelected
                      ? context.colorScheme.onInverseSurface
                      : context.colorScheme.onSurface,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _productGrid(List<Product> products) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: kGap_3,
        mainAxisSpacing: kGap_3,
      ),
      itemBuilder: (_, int index) {
        final Product product = products[index];
        return productCard(product, context);
      },
    );
  }
}

///
Widget productCard(Product product, BuildContext context) {
  final NavigatorState navigator = Navigator.of(context);
  final double width = MediaQuery.of(context).size.width;
  return Container(
    clipBehavior: Clip.hardEdge,
    height: width * 0.6,
    decoration: BoxDecoration(
      color: context.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(kGap_1),
    ),
    child: GestureDetector(
      onTap: () async {
        await navigator.push(
          MaterialPageRoute<dynamic>(
            builder: (BuildContext _) => ProductDetailScreen(
              product: product,
            ),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Flexible(
              child: Hero(
            tag: product.id,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.imgUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: kGap_1, horizontal: kGap_2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// Name
                Text(
                  product.name,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: kGap_0),

                /// Price
                Text(
                  r'$' + product.price.toString(),
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
