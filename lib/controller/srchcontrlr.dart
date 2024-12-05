import 'package:get/get.dart';

import '../model/productmodel.dart';

class SrchController extends GetxController {
  var searchResults = <Product>[].obs;
  var isSearching = false.obs;

  void searchProducts(String query, List<Product> allProducts) {
    isSearching(true);

    if (query.isEmpty) {
      searchResults.clear();
    } else {
      searchResults.assignAll(
        allProducts.where((product) {
          final productName = product.productName?.toLowerCase() ?? '';
          return productName.contains(query.toLowerCase());
        }),
      );
    }

    isSearching(false);
  }
}
