// import 'package:get/get.dart';
// import '../model/productmodel.dart';

// class CartController extends GetxController {
//   // Observable list of cart items
//   var cartItems = <Product>[].obs;

//   // Observable for total price
//   var totalPrice = 0.0.obs;

//   // Add item to cart
//   void addToCart(Product product) {
//     if (!cartItems.contains(product)) {
//       // Add new item with initial quantity set to 1 (if not present)
//       product.minimumOrderQuantity = (product.minimumOrderQuantity ?? 0) + 1;
//       cartItems.add(product);
//     } else {
//       // If item already exists, increment its quantity
//       product.minimumOrderQuantity = (product.minimumOrderQuantity ?? 0) + 1;
//     }
//     calculateTotalPrice();

//     // Show success message
//     Get.snackbar(
//       'Added to Cart',
//       '${product.productName ?? "Item"} has been added to your cart.',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   // Remove a single quantity of an item or remove it entirely
//   void removeFromCart(Product product) {
//     if (cartItems.contains(product)) {
//       cartItems.remove(product);
//       calculateTotalPrice();
//     }

//     // Show removal message
//     Get.snackbar(
//       'Removed from Cart',
//       '${product.productName ?? "Item"} has been removed from your cart.',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   // Increase quantity for a specific product
//   void increaseQuantity(Product product) {
//     if (cartItems.contains(product)) {
//       product.minimumOrderQuantity = (product.minimumOrderQuantity ?? 0) + 1;
//       calculateTotalPrice();

//       // Optional snackbar
//       // Get.snackbar(
//       //   'Quantity Updated',
//       //   '${product.productName ?? "Item"} quantity increased.',
//       //   snackPosition: SnackPosition.BOTTOM,
//       // );
//     }
//   }

//   // Decrease quantity for a specific product
//   void decreaseQuantity(Product product) {
//     if (cartItems.contains(product)) {
//       if ((product.minimumOrderQuantity ?? 0) > 1) {
//         product.minimumOrderQuantity = (product.minimumOrderQuantity ?? 0) - 1;
//         calculateTotalPrice();

//         // Optional snackbar
//         // Get.snackbar(
//         //   'Quantity Updated',
//         //   '${product.productName ?? "Item"} quantity decreased.',
//         //   snackPosition: SnackPosition.BOTTOM,
//         // );
//       } else {
//         // Remove item entirely if quantity becomes 0
//         removeFromCart(product);
//       }
//     }
//   }

//   // Clear the entire cart
//   void clearCart() {
//     cartItems.clear();
//     calculateTotalPrice();

//     // Show cleared message
//     Get.snackbar(
//       'Cart Cleared',
//       'All items have been removed from your cart.',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   // Calculate total price of items in the cart
//   void calculateTotalPrice() {
//     totalPrice.value = cartItems.fold(
//       0.0,
//       (sum, item) =>
//           sum +
//           ((item.price ?? 0) * (item.minimumOrderQuantity ?? 1)), // Handle null
//     );
//   }
// }

import 'package:get/get.dart';
import '../model/productmodel.dart';

class CartController extends GetxController {
  // Observable list of cart items
  var cartItems = <Product>[].obs;

  // Observable for total price
  var totalPrice = 0.0.obs;

  // Options for summary selection
  var addSample = false.obs;
  var addDisplayStand = false.obs;
  var addBrochure = false.obs;
  var addLeafcoin = false.obs;

  // Add item to cart
  void addToCart(Product product) {
    var existingProduct =
        cartItems.firstWhereOrNull((item) => item.id == product.id);

    if (existingProduct == null) {
      // If not present, add new product with initial quantity of 1
      product.minimumOrderQuantity = (product.minimumOrderQuantity ?? 0) + 1;
      cartItems.add(product);
    } else {
      // If already exists, increment quantity
      existingProduct.minimumOrderQuantity =
          (existingProduct.minimumOrderQuantity ?? 0) + 1;
    }
    calculateTotalPrice();

    // Show success message
    Get.snackbar(
      'Added to Cart',
      '${product.productName ?? "Item"} has been added to your cart.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Remove a single quantity of an item or remove it entirely
  void removeFromCart(Product product) {
    var existingProduct =
        cartItems.firstWhereOrNull((item) => item.id == product.id);

    if (existingProduct != null) {
      cartItems.remove(existingProduct);
      calculateTotalPrice();

      // Show removal message
      Get.snackbar(
        'Removed from Cart',
        '${product.productName ?? "Item"} has been removed from your cart.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Increase quantity for a specific product
  void increaseQuantity(Product product) {
    var existingProduct =
        cartItems.firstWhereOrNull((item) => item.id == product.id);

    if (existingProduct != null) {
      existingProduct.minimumOrderQuantity =
          (existingProduct.minimumOrderQuantity ?? 0) + 1;
      calculateTotalPrice();
    }
  }

  // Decrease quantity for a specific product
  void decreaseQuantity(Product product) {
    var existingProduct =
        cartItems.firstWhereOrNull((item) => item.id == product.id);

    if (existingProduct != null) {
      if ((existingProduct.minimumOrderQuantity ?? 0) > 1) {
        existingProduct.minimumOrderQuantity =
            (existingProduct.minimumOrderQuantity ?? 0) - 1;
        calculateTotalPrice();
      } else {
        // Remove item entirely if quantity becomes 0
        removeFromCart(product);
      }
    }
  }

  // Clear the entire cart
  void clearCart() {
    cartItems.clear();
    calculateTotalPrice();

    // Show cleared message
    Get.snackbar(
      'Cart Cleared',
      'All items have been removed from your cart.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Calculate total price of items in the cart
  void calculateTotalPrice() {
    totalPrice.value = cartItems.fold(
      0.0,
      (sum, item) =>
          sum +
          ((item.price ?? 0) *
              (item.minimumOrderQuantity ?? 1)), // Handle null values
    );
  }

  // Options for additional items
  double get discountPrice => totalPrice.value > 100 ? 10.0 : 0.0;

  double get finalPrice =>
      totalPrice.value +
      (addSample.value ? 5.0 : 0.0) +
      (addDisplayStand.value ? 10.0 : 0.0) +
      (addBrochure.value ? 2.0 : 0.0) +
      (addLeafcoin.value ? 1.0 : 0.0) -
      discountPrice;

  // Toggle methods for additional items
  void toggleAddSample(bool value) => addSample.value = value;
  void toggleAddDisplayStand(bool value) => addDisplayStand.value = value;
  void toggleAddBrochure(bool value) => addBrochure.value = value;
  void toggleAddLeafcoin(bool value) => addLeafcoin.value = value;

  // Checkout method
  void checkout() {
    cartItems.clear();
    totalPrice.value = 0.0;
    addSample.value = false;
    addDisplayStand.value = false;
    addBrochure.value = false;
    addLeafcoin.value = false;
  }
}
