import 'package:first_app/models/product.dart';
import 'package:first_app/widget/products/products.dart';
import 'package:flutter/material.dart';

class ProductManager extends StatelessWidget {
  List<Product> products = [];

  ProductManager(this.products);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: Products(products))],
    );
  }
}
