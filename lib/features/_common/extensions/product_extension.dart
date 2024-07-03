import '../../features.dart';

/// [Product] extension
extension ProductExtensions on List<Product> {
  /// Returns all categories in [Product] list
  List<String> getCategories() {
    final List<String> categories = <String>[];

    // Added default category
    categories.add('All');

    for (final Product product in this) {
      if (!categories.contains(product.catergory)) {
        categories.add(product.catergory);
      }
    }
    return categories;
  }

  /// Returns all products that matches category
  List<Product> filterByCategory(String category) {
    /// Returns all products if category is all
    if (category == 'All') return this;
    return where((Product p) => p.catergory == category).toList();
  }
}
