import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/app_controller.dart';
import '../widgets/catlist.dart';
import 'categoryproduct.dart';

class HomeScreen extends StatelessWidget {
  final AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories & Products'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Top Categories"),
              // Categories Section
              Cataglist(controller: controller),

              Divider(),
              Text(
                "Best Selling",
                style: TextStyle(),
              ),

              // All Products Section
              Obx(() {
                if (controller.isLoadingProducts.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.products.isEmpty) {
                  return Center(child: Text('No products available.'));
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7, // Adjust to control the card size
                  ),
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Product Image
                          product.image != null
                              ? Expanded(
                                  child: Image.network(
                                    product.image!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.image_not_supported),
                                  ),
                                )
                              : Expanded(
                                  child: Icon(Icons.image, size: 50),
                                ),
                          // Product Name
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.productName ?? 'Unnamed Product',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Product Price
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Price: ${product.price ?? 'N/A'}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
