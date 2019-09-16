import 'package:flutter/material.dart';
import './pages/ProductPage.dart';

class Prodects extends StatelessWidget {
  final List<Map<String, String>> product;
  final Function deleteProduct;
  Prodects(this.product, {this.deleteProduct});

  Widget buildProducetItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product[index]['image']),
          Text(product[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProductPage(
                        product[index]['title'], product[index]['image']),
                  ),
                ).then((bool value) {
                  if (value) {
                    deleteProduct(index);
                  }
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildProductList() {
    Widget productCards;
    if (product.isNotEmpty) {
      productCards = ListView.builder(
        itemBuilder: buildProducetItem,
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
