import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/app_controller.dart';
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
        child: Column(
          children: [
            // Categories Section
            Obx(() {
              if (controller.isLoadingCategories.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.categories.isEmpty) {
                return Center(child: Text('No categories available.'));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return ListTile(
                    title: Text(category.name ?? 'Unnamed Category'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to CategoryProductPage
                      Get.to(() => CategoryProductPage(category: category));
                    },
                  );
                },
              );
            }),

            Divider(),

            // All Products Section
            Obx(() {
              if (controller.isLoadingProducts.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.products.isEmpty) {
                return Center(child: Text('No products available.'));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ListTile(
                    title: Text(product.productName ?? 'Unnamed Product'),
                    subtitle: Text('Price: ${product.price ?? 'N/A'}'),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
