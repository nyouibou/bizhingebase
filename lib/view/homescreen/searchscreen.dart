import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/app_controller.dart';
import '../../controller/srchcontrlr.dart';
import '../widgets/catlist.dart';
import 'productdetail.dart';

class SearchScreen extends StatelessWidget {
  final AppController appController = Get.find();
  final SrchController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Search Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (query) {
                searchController.searchProducts(query, appController.products);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (searchController.isSearching.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (searchController.searchResults.isEmpty) {
                // Show categories in idle state using Cataglist
                return Cataglist(controller: appController);
              }

              // Show search results
              return ListView.builder(
                itemCount: searchController.searchResults.length,
                itemBuilder: (context, index) {
                  final product = searchController.searchResults[index];
                  return ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: Text(product.productName ?? ''),
                    subtitle: Text('Price: ${product.price}'),
                    onTap: () {
                      // Navigate to ProductDetail
                      Get.to(() => ProductDetail(product: product));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
