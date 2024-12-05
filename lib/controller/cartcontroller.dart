import 'package:get/get.dart';
import '../model/productmodel.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var quantities = <Product, int>{}.obs;

  // Calculate total price
  double get totalPrice => cartItems.fold(
        0,
        (sum, item) {
          final itemPrice = item.price ?? 0.0; // Use double directly
          return sum + (itemPrice * (quantities[item] ?? 1));
        },
      );

  // Add item to cart
  void addToCart(Product product) {
    if (cartItems.contains(product)) {
      quantities[product] = (quantities[product] ?? 1) + 1;
    } else {
      cartItems.add(product);
      quantities[product] = 1;
    }

    Get.snackbar(
      'Added to Cart',
      '${product.productName} has been added to your cart.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Remove item from cart
  void removeFromCart(Product product) {
    if (quantities[product] != null && quantities[product]! > 1) {
      quantities[product] = quantities[product]! - 1;
    } else {
      cartItems.remove(product);
      quantities.remove(product);
    }

    Get.snackbar(
      'Removed from Cart',
      '${product.productName} has been removed from your cart.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Clear the entire cart
  void clearCart() {
    cartItems.clear();
    quantities.clear();
    Get.snackbar(
      'Cart Cleared',
      'All items have been removed from your cart.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
