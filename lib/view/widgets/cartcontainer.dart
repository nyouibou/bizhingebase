import 'package:flutter/material.dart';

import '../../controller/cartcontroller.dart';
import '../../model/productmodel.dart';

class CartContainer extends StatelessWidget {
  const CartContainer({
    super.key,
    required this.product,
    required this.cartController,
  });

  final Product product;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(12),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.network(
            product.image ?? '',
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        product.productName ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'medicine',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '₹${product.price?.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              cartController.removeFromCart(product);
            },
            child: const Icon(
              Icons.close,
              color: Colors.grey,
              size: 20,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    cartController.decreaseQuantity(product);
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
                Text(
                  '${product.minimumOrderQuantity}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cartController.increaseQuantity(product);
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
