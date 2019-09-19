import 'package:first_app/products_control.dart';
import 'package:flutter/material.dart';

import './products.dart';

class ProductManager extends StatelessWidget {
  List<Map<String, String>> products = [];

  final Function addProduct;
  final Function deleteProduct;

  ProductManager(this.products, this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(10.0), child: ProductControl(addProduct)),
        Expanded(child: Prodects(products, deleteProduct: deleteProduct))
      ],
    );
  }
}
