import 'package:first_app/models/product.dart';
import 'package:first_app/scoped-models/products.dart';
import 'package:first_app/widget/products/producet_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> product) {
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

  @override
  Widget build(context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return _buildProductList(model.products);
    });
  }
}
