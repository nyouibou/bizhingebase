import 'package:flutter/material.dart';

import '../../controller/apicontroller.dart';
import '../../model/catmodelresp.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CatModelApiResp>> _categoryData;

  @override
  void initState() {
    super.initState();
    _categoryData = ApiService().fetchCategories(); // Fetch categories from API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories and Products'),
      ),
      body: FutureBuilder<List<CatModelApiResp>>(
        future: _categoryData, // Provide the future you want to display
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading state
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); // Error state
          } else if (snapshot.hasData) {
            // Successfully loaded the data
            List<CatModelApiResp> categoryData = snapshot.data!;
            return ListView.builder(
              itemCount: categoryData.length,
              itemBuilder: (context, index) {
                return CategoryWidget(categoryData: categoryData[index]);
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final CatModelApiResp categoryData;

  CategoryWidget({required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                categoryData.name ?? 'No Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Products:'),
            ),
            // Display list of products
            ListView.builder(
              shrinkWrap:
                  true, // This makes the list scrollable within the parent
              physics:
                  NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView
              itemCount: categoryData.products?.length ?? 0,
              itemBuilder: (context, index) {
                Product product = categoryData.products![index];
                return ProductWidget(product: product);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: product.image != null
          ? Image.network(product.image!,
              width: 50, height: 50, fit: BoxFit.cover)
          : Icon(Icons.image, size: 50),
      title: Text(product.productName ?? 'Unnamed Product'),
      subtitle: Text(product.productDetails ?? 'No details available'),
      trailing: Text('\$${product.price ?? "N/A"}'),
    );
  }
}
