import 'package:first_app/widget/products/producet_card.dart';
import 'package:flutter/material.dart';

class Prodects extends StatelessWidget {
  final List<Map<String, dynamic>> product;

  Prodects(this.product);

  Widget buildProductList() {
    Widget productCards;
    if (product.isNotEmpty) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(product[index], index),
        itemCount: product.length,
      );
    } else {
      // if you don't need to return any widget return empty container
      //productCards=Container();

      productCards = Center(
        child: Text('There is no products to display , please add some'),
      );
    }
    return productCards;
  }

  Widget build(context) {
    return buildProductList();
  }
}
