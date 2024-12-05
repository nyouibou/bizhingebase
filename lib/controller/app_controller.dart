import 'package:get/get.dart';

import '../model/categorymodel.dart';
import '../model/productmodel.dart';
import 'apicontroller.dart';

class AppController extends GetxController {
  var categories = <Category>[].obs;
  var products = <Product>[].obs;
  var isLoadingCategories = true.obs;
  var isLoadingProducts = true.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }

  void fetchCategories() async {
    try {
      isLoadingCategories(true);
      var fetchedCategories = await _apiService.fetchCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories: $e');
    } finally {
      isLoadingCategories(false);
    }
  }

  void fetchProducts() async {
    try {
      isLoadingProducts(true);
      var fetchedProducts = await _apiService.fetchProducts();
      products.assignAll(fetchedProducts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products: $e');
    } finally {
      isLoadingProducts(false);
    }
  }
}
