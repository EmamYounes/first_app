import 'package:first_app/widget/products/products.dart';
import 'package:flutter/material.dart';

class ProductManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: Products())],
    );
  }
}
