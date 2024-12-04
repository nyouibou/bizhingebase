import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/app_controller.dart';
import '../widgets/catlist.dart';
// import 'categoryproduct.dart';

class HomeScreen extends StatelessWidget {
  final List<String> banners = [
    "assets/img_5.png",
    "assets/img_5.png",
  ];
  final AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // Navigate to profile page
            },
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 25,
            ),
          ),
        ),
        title: Text("data"),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to wallet page
            },
            icon: Icon(Icons.account_balance_wallet_outlined,
                color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              // Navigate to notifications page
            },
            icon: Icon(Icons.notifications_none_outlined, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                itemCount: banners.length,
                itemBuilder: (context, index, _) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(banners[index]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 162,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  enlargeCenterPage: true,
                ),
              ),

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
