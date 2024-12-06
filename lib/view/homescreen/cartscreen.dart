import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cartcontroller.dart';
import '../widgets/cartcontainer.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Text(
              'Your cart is empty!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartController.cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CartContainer(
                          product: product,
                          cartController: cartController,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff6EBC31).withOpacity(0.84),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xff6EBC31)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.eco,
                                size: 20, color: Colors.black),
                            const SizedBox(width: 8),
                            Text(
                              'You will get 10 leaf coins',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        buildRow(
                          'Sub total',
                          '₹${cartController.totalPrice.value.toStringAsFixed(2)}',
                        ),
                        const SizedBox(height: 8),
                        buildOptionRow(
                            'Add a sample', cartController.addSample.value,
                            (value) {
                          cartController.toggleAddSample(value);
                        }),
                        buildOptionRow('Add display stand',
                            cartController.addDisplayStand.value, (value) {
                          cartController.toggleAddDisplayStand(value);
                        }),
                        buildOptionRow(
                            'Add brochure', cartController.addBrochure.value,
                            (value) {
                          cartController.toggleAddBrochure(value);
                        }),
                        buildOptionRow(
                            'Add leafcoin', cartController.addLeafcoin.value,
                            (value) {
                          cartController.toggleAddLeafcoin(value);
                        }),
                        const SizedBox(height: 8),
                        buildRow(
                          'Discount price',
                          '(₹${cartController.discountPrice.toStringAsFixed(2)})',
                        ),
                        const SizedBox(height: 8),
                        buildRow('Delivery Charge', 'Free'),
                        const SizedBox(height: 8),
                        const Divider(color: Colors.white),
                        const SizedBox(height: 8),
                        buildRow(
                          'Total',
                          '₹${cartController.finalPrice.toStringAsFixed(2)}',
                          isBold: true,
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: SizedBox(
                            height: 44,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                cartController.checkout();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Checkout complete!'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff2E7D32),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: const Text(
                                'Proceed to Checkout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildOptionRow(
      String label, bool isChecked, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Switch(
          value: isChecked,
          onChanged: onChanged,
          activeColor: Colors.white,
        ),
      ],
    );
  }
}
