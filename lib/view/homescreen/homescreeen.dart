import 'package:flutter/material.dart';

import '../../controller/apicontroller.dart';
import '../../model/catmodelresp.dart';

class HomeScreeen extends StatefulWidget {
  @override
  _HomeScreeenState createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  late Future<List<Product>> _productData;

  @override
  void initState() {
    super.initState();
    _productData =
        ApiService().fetchAllProducts(); // Fetch all products from API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productData, // Provide the future you want to display
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading state
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); // Error state
          } else if (snapshot.hasData) {
            // Successfully loaded the data
            List<Product> productList = snapshot.data!;
            return ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductWidget(product: productList[index]);
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
