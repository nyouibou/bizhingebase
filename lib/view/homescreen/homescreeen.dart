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
        title: Text('Best Selling'),
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
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 8.0, // Horizontal spacing between items
                mainAxisSpacing: 8.0, // Vertical spacing between items
                childAspectRatio:
                    0.75, // Aspect ratio of each item (width/height)
              ),
              itemCount: productList.length, // Display all items
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
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wrap the image with ClipRRect to make it curved
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0)), // Curved top corners
              child: product.image != null
                  ? Image.network(
                      product.image!,
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.image, size: 120, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.productName ?? 'Unnamed Product',
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.productDetails ?? 'No details available',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$${product.price ?? "N/A"}',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
