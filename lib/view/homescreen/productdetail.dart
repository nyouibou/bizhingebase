import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cartcontroller.dart';
import '../../model/productmodel.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the CartController
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(product.productName ?? 'Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Name
            Text(
              product.productName ?? 'Unnamed Product',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Product Price
            Text(
              'Price: ${product.price}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),

            // Product Description
            Text(
              product.productDetails ?? 'No description available.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Add to Cart Button
            ElevatedButton(
              onPressed: () {
                cartController.addToCart(product);
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
