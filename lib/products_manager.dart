import 'package:flutter/material.dart';

import 'widget/products/products.dart';

class ProductManager extends StatelessWidget {
  List<Map<String, dynamic>> products = [];

  ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: Prodects(products))],
    );
  }
}
