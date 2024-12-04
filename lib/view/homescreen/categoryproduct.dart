import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/app_controller.dart';
import '../../model/categorymodel.dart';

class CategoryProductPage extends StatelessWidget {
  final Category category;
  final AppController controller = Get.find();

  CategoryProductPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryProducts = controller.products
        .where((product) => product.category == category.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${category.name} Products'),
      ),
      body: categoryProducts.isEmpty
          ? Center(child: Text('No products available for this category.'))
          : ListView.builder(
              itemCount: categoryProducts.length,
              itemBuilder: (context, index) {
                final product = categoryProducts[index];
                return ListTile(
                  leading: product.image != null
                      ? Image.network(
                          product.image!,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported),
                        )
                      : Icon(Icons.image),
                  title: Text(product.productName ?? 'Unnamed Product'),
                  subtitle: Text('Price: ${product.price ?? 'N/A'}'),
                );
              },
            ),
    );
  }
}
